class_name FourWaySpeedupPushZoneCamera
extends CameraControllerBase

@export var push_ratio:float = 0.8
@export var pushbox_top_left:Vector2 = Vector2(-10, 10)
@export var pushbox_bottom_right:Vector2 = Vector2(10, -10)
@export var speedup_zone_top_left:Vector2 = Vector2(-7, 7)
@export var speedup_zone_bottom_right:Vector2 = Vector2(7, -7)


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
		
	# boundary checks
	var pushbox_right:float = pushbox_bottom_right.x
	var pushbox_left:float = pushbox_top_left.x
	var pushbox_up:float = pushbox_top_left.y
	var pushbox_down:float = pushbox_bottom_right.y
	var speedup_right:float = speedup_zone_bottom_right.x
	var speedup_left:float = speedup_zone_top_left.x
	var speedup_up:float = speedup_zone_top_left.y
	var speedup_down:float = speedup_zone_bottom_right.y
	var x_diff_between_target_and_camera:float = tpos.x - cpos.x
	var z_diff_between_target_and_camera:float = tpos.z - cpos.z
	
	# if vessel inside speedup zone, don't move camera
	if (x_diff_between_target_and_camera < speedup_right and \
		x_diff_between_target_and_camera >= 0 and \
		z_diff_between_target_and_camera < speedup_up):
		return
	if (x_diff_between_target_and_camera < speedup_right and \
		x_diff_between_target_and_camera >= 0 and \
		z_diff_between_target_and_camera > speedup_down):
		return	
	if (x_diff_between_target_and_camera > speedup_left and \
		x_diff_between_target_and_camera < 0 and \
		z_diff_between_target_and_camera < speedup_up):
		return
	if (x_diff_between_target_and_camera > speedup_left and \
		x_diff_between_target_and_camera < 0 and \
		z_diff_between_target_and_camera > speedup_down):
		return
	
	# if vessel between speedup zone border and outer pushbox, move at
	# push_ratio * target's speed
	# up
	if (z_diff_between_target_and_camera > speedup_up and \
		z_diff_between_target_and_camera < pushbox_up):
			global_position.z += push_ratio * target.BASE_SPEED * delta
	# down
	if (z_diff_between_target_and_camera < speedup_down and \
		z_diff_between_target_and_camera > pushbox_down):
			global_position.z -= push_ratio * target.BASE_SPEED * delta
	# left
	if (x_diff_between_target_and_camera < speedup_left and \
		x_diff_between_target_and_camera > pushbox_left):
			global_position.x -= push_ratio * target.BASE_SPEED * delta
	# right
	if (x_diff_between_target_and_camera > speedup_right and \
		x_diff_between_target_and_camera < pushbox_right):
			global_position.x += push_ratio * target.BASE_SPEED * delta
	
	# if vessel touching outer pushbox border
	# up
	if (z_diff_between_target_and_camera == pushbox_up and \
		target.direction.z > 0):
			global_position.z += target.BASE_SPEED * delta
	# down
	if (z_diff_between_target_and_camera == pushbox_down and \
		target.direction.z < 0):
			global_position.z -= target.BASE_SPEED * delta
	# left
	if (x_diff_between_target_and_camera == pushbox_left and \
		target.direction.x < 0):
			global_position.x -= target.BASE_SPEED * delta
	# right
	if (x_diff_between_target_and_camera == pushbox_right and \
		target.direction.x > 0):
			global_position.x += target.BASE_SPEED * delta
	
	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var pushbox_right:float = pushbox_bottom_right.x
	var pushbox_left:float = pushbox_top_left.x
	var pushbox_up:float = pushbox_top_left.y
	var pushbox_down:float = pushbox_bottom_right.y
	var speedup_right:float = speedup_zone_bottom_right.x
	var speedup_left:float = speedup_zone_top_left.x
	var speedup_up:float = speedup_zone_top_left.y
	var speedup_down:float = speedup_zone_bottom_right.y
	
	# draw outer pushbox
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# top side
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_up))
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_up))
	# right side
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_up))
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_down))
	# bottom side
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0, speedup_down))
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_down))
	# left side
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_down))
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0, speedup_up))
	immediate_mesh.surface_end()
	
	# draw speedup zone box
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# top side
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_up))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_up))
	# right side
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_up))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_down))
	# bottom side
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0, pushbox_down))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_down))
	# left side
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_down))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0, pushbox_up))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
