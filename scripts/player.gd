extends CharacterBody3D

@onready var camera_rig = $CameraRig
@onready var inventory_container = $Inventory

## Basic variables for movement exported to easily change in  inspector
# Speed variable in meters per second
@export var speed = 200

## Other variables
# Target velocity
var target_velocity = Vector3.ZERO
var inventory_input_pressed = false

## Process
func _process(delta: float) -> void:
	show_inventory()

## Movement
# Movement direction based on inputs
func _physics_process(delta):
	# Variable for storing input direction
	var direction = Vector3.ZERO
	# Variables for movement commands
	var moving_commands_back = {
		Vector3(0,   0,    0): {"Val": [{"Dir": "z"}, {"Num": 1}]},
		Vector3(0,  90,    0): {"Val": [{"Dir": "x"}, {"Num": 1}]},
		Vector3(0, 180,    0): {"Val": [{"Dir": "z"}, {"Num": -1}]},
		Vector3(0, 270,    0): {"Val": [{"Dir": "x"}, {"Num": -1}]},
		Vector3(0, -90,    0): {"Val": [{"Dir": "x"}, {"Num": -1}]},
		Vector3(0, -180,   0): {"Val": [{"Dir": "z"}, {"Num": -1}]},
		Vector3(0, -270,   0): {"Val": [{"Dir": "x"}, {"Num": 1}]}}
	var moving_commands_forward = {
		Vector3(0,    0,    0): {"Val": [{"Dir": "z"}, {"Num": -1}]},
		Vector3(0,   90,    0): {"Val": [{"Dir": "x"}, {"Num": -1}]},
		Vector3(0,  180,    0): {"Val": [{"Dir": "z"}, {"Num":  1}]},
		Vector3(0,  270,    0): {"Val": [{"Dir": "x"}, {"Num":  1}]},
		Vector3(0,  -90,    0): {"Val": [{"Dir": "x"}, {"Num":  1}]},
		Vector3(0, -180,    0): {"Val": [{"Dir": "z"}, {"Num":  1}]},
		Vector3(0, -270,    0): {"Val": [{"Dir": "x"}, {"Num": -1}]}}

	# Variable for rotation saving
	var camera_rotation = round(camera_rig.rotation_degrees)
	
	# Checking for inputs
	if Input.is_action_just_pressed("move_right"):
		camera_rig.rotate_y(deg_to_rad(-90))
		print(rad_to_deg(camera_rotation.y))
	elif Input.is_action_just_pressed("move_left"):
		camera_rig.rotate_y(deg_to_rad(90))
		print(rad_to_deg(camera_rotation.y))
	elif Input.is_action_just_pressed("move_back"):
		var direction_back = moving_commands_back[round(camera_rotation)]["Val"][0]["Dir"]
		var num_back = moving_commands_back[round(camera_rotation)]["Val"][1]["Num"]
		match direction_back:
			"x":
				direction.x += num_back
			"z":
				direction.z += num_back
	elif Input.is_action_just_pressed("move_forward"):
		var direction_forward = moving_commands_forward[round(camera_rotation)]["Val"][0]["Dir"]
		var num_forward = moving_commands_forward[round(camera_rotation)]["Val"][1]["Num"]
		match direction_forward:
			"x":
				direction.x += num_forward
			"z":
				direction.z += num_forward
	
	# Checking if the direction value has changed by inputs
	if direction != Vector3.ZERO:
		# Normalizing direction value
		direction = direction.normalized()
	
	# Ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Finnaly character moving
	velocity = target_velocity
	move_and_slide()

## Inventory Input
func show_inventory():
	if Input.is_action_just_pressed("Show Inventory"):
		match inventory_input_pressed:
			false:
				inventory_container.show()
				inventory_input_pressed = true
				print(inventory_input_pressed)
			true:
				inventory_container.hide()
				inventory_input_pressed = false
				print(inventory_input_pressed)
