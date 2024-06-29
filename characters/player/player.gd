extends CharacterBody3D

@onready var camera_3d = $Camera3D
@onready var character_mover = $CharacterMover

@export var mouse_sensitivity_h = 0.15
@export var mouse_sensitivity_v = 0.15

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity_h
		camera_3d.rotation_degrees.x -= clamp(event.relative.y * mouse_sensitivity_v, -90, 90)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("fullscreen"):
		var fs = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		
		if fs:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var move_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	character_mover.set_move_dir(move_dir)
	
	if Input.is_action_just_pressed("jump"):
		character_mover.jump()
