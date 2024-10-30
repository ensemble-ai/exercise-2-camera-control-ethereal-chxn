class_name PositionLockCamera
extends CameraControllerBase


@export var cross_length:float = 5.0


func _ready() -> void:
	super()
	position = target.position

	
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	global_position.x = target.global_position.x
	global_position.z = target.global_position.z
	
	super(delta)

	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# draw vertical line
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -1 * cross_length / 2))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, cross_length / 2))
	immediate_mesh.surface_end()
	# draw horizontal line
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-1 * cross_length / 2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(cross_length / 2, 0, 0))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
	
	
	
