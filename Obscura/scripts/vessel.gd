class_name Vessel
extends CharacterBody3D

@export var terrforming_power:float = 1.0
@export var terrain_manager:TerrainManager

const RADIUS:float = 0.5
const HEIGHT:float = RADIUS * 2.0
const WIDTH:float = RADIUS * 2.0

const BASE_SPEED = 50
const HYPER_SPEED = 300

func _process(_delta):
	
	var speed = BASE_SPEED
	$ParticleTrail.visible = false 
	if Input.is_action_pressed("ui_accept"):
		_play($Audio/HyperSpeed)
		speed = HYPER_SPEED
		$ParticleTrail.visible = true

	if Input.is_action_just_pressed("raise_terrain"):
		_play($Audio/Terraforming)
		terrain_manager.move_vertex_below_position(global_position, terrforming_power)
		
	if Input.is_action_just_pressed("lower_terrain"):
		_play($Audio/Terraforming)
		terrain_manager.move_vertex_below_position(global_position, -terrforming_power)

	
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).limit_length(1.0)
	
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _play(player:AudioStreamPlayer2D) -> void:
	if !player.playing:
		player.play()
