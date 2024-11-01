class_name FrameboundAutoscrollCamera
extends CameraControllerBase

# stores top left corner of frame border box
@export var top_left:Vector2
# stores bottom right corner of frame border box
@export var bottom_right:Vector2
# stores speed to scroll along each axis
@export var autoscroll_speed:Vector3


func _ready() -> void:
	super()
	position = target.position
	

func _process(delta:float) -> void:
	if !current:
		position = target.position
		return
		
	if draw_camera_logic:
		draw_logic()
	
	# move camera along
	global_position += delta * autoscroll_speed
	
	# boundary checks
	var target_pos = target.global_position
	var camera_pos = global_position
	
	# left boundary check
	var diff_between_left_edges = (target_pos.x - target.WIDTH / 2.0) - (camera_pos.x + top_left.x)
	# push player along if player is touching left side of frame
	if diff_between_left_edges < 0:
		target.global_position.x += abs(diff_between_left_edges)
		
	# right boundary check
	var diff_between_right_edges = (target_pos.x + target.WIDTH / 2.0) - (camera_pos.x + bottom_right.x)
	# prevent player from passing right side of frame
	if diff_between_right_edges > 0:
		target.global_position.x -= abs(diff_between_right_edges)
	
	# top boundary check
	var diff_between_top_edges = (target_pos.z + target.WIDTH / 2.0) - (camera_pos.z + top_left.y)
	# prevent player from passing top side of frame
	if diff_between_top_edges > 0:
		target.global_position.z -= abs(diff_between_top_edges)
	
	# bottom boundary check
	var diff_between_bottom_edges = (target_pos.z - target.WIDTH / 2.0) - (camera_pos.z + bottom_right.y)
	if diff_between_bottom_edges < 0:
		target.global_position.z += abs(diff_between_bottom_edges)
		
	super(delta)
		

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left = top_left.x
	var right = bottom_right.x
	var top = top_left.y
	var bottom = bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	# top side of frame
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	
	# right side of frame
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	# bottom side of frame
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	# left side of frame
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
