class_name FourWaySpeedupPushZoneCamera
extends CameraControllerBase

# export variables
@export var push_ratio:float = 0.8
@export var pushbox_top_left:Vector2 = Vector2(-10, 10)
@export var pushbox_bottom_right:Vector2 = Vector2(10, -10)
@export var speedup_zone_top_left:Vector2 = Vector2(-5, 5)
@export var speedup_zone_bottom_right:Vector2 = Vector2(5, -5)

# public variables
var pushbox_right:float = pushbox_bottom_right.x
var pushbox_left:float = pushbox_top_left.x
var pushbox_up:float = pushbox_top_left.y
var pushbox_down:float = pushbox_bottom_right.y
var speedup_right:float = speedup_zone_bottom_right.x
var speedup_left:float = speedup_zone_top_left.x
var speedup_up:float = speedup_zone_top_left.y
var speedup_down:float = speedup_zone_bottom_right.y


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position

	var diff_from_pushbox_left = (tpos.x - target.WIDTH / 2.0) - (cpos.x + pushbox_left)
	var diff_from_pushbox_right = (tpos.x + target.WIDTH / 2.0) - (cpos.x + pushbox_right)
	var diff_from_pushbox_up = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_up)
	var diff_from_pushbox_down = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + pushbox_down)
	var diff_from_speedup_left = (tpos.x - target.WIDTH / 2.0) - (cpos.x + speedup_left)
	var diff_from_speedup_right = (tpos.x + target.WIDTH / 2.0) - (cpos.x + speedup_right)
	var diff_from_speedup_up = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + speedup_up)
	var diff_from_speedup_down = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + speedup_down)
	
	# if vessel touching outer pushbox border
	# top left corner
	if diff_from_pushbox_left < 0 and diff_from_pushbox_up > 0:
		global_position.x -= target.BASE_SPEED * delta
		global_position.z += target.BASE_SPEED * delta
	# top right corner
	if diff_from_pushbox_right > 0 and diff_from_pushbox_up > 0:
		global_position.x += target.BASE_SPEED * delta
		global_position.z += target.BASE_SPEED * delta
	# bottom left corner
	if diff_from_pushbox_left < 0 and diff_from_pushbox_down < 0:
		global_position.x -= target.BASE_SPEED * delta
		global_position.z -= target.BASE_SPEED * delta
	# bottom right corner
	if diff_from_pushbox_right > 0 and diff_from_pushbox_down < 0:
		global_position.x += target.BASE_SPEED * delta
		global_position.z -= target.BASE_SPEED * delta
	# left
	if diff_from_pushbox_left < 0:
		global_position.x -= target.BASE_SPEED * delta
	# right
	if diff_from_pushbox_right > 0:
		global_position.x += target.BASE_SPEED * delta
	# up
	if diff_from_pushbox_up > 0:
		global_position.z += target.BASE_SPEED * delta
	# down
	if diff_from_pushbox_down < 0:
		global_position.z -= target.BASE_SPEED * delta
	
	# if vessel between speedup zone and pushbox border
	# left
	if diff_from_speedup_left < 0 and diff_from_pushbox_left > 0 \
	and target.velocity != Vector3(0, 0, 0):
		global_position.x -= push_ratio * target.BASE_SPEED * delta
	# right
	if diff_from_speedup_right > 0 and diff_from_pushbox_right < 0 \
	and target.velocity != Vector3(0, 0, 0):
		global_position.x += push_ratio * target.BASE_SPEED * delta
	# up
	if diff_from_speedup_up > 0 and diff_from_speedup_up < 0 \
	and target.velocity != Vector3(0, 0, 0):
		global_position.z += push_ratio * target.BASE_SPEED * delta
	# down
	if diff_from_speedup_down < 0 and diff_from_pushbox_down > 0 \
	and target.velocity != Vector3(0, 0, 0):
		global_position.z -= push_ratio * target.BASE_SPEED * delta
	
	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
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
