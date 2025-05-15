extends CharacterBody3D

@onready var camera_rig = $CameraRig

## Basic variables for movement exported to easily change in  inspector
# Speed variable in meters per second
@export var speed = 200

## Other variables
# Target velocity
var target_velocity = Vector3.ZERO


## Movement
# Movement direction based on inputs
func _physics_process(delta):
	# Variable for storing input direction
	var direction = Vector3.ZERO
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
		if round(camera_rotation) == Vector3(0, 0, 0):
			direction.z += 1
		elif round(camera_rotation) == Vector3(0, 90, 0):
			direction.x += 1
			print(camera_rotation)
		elif round(camera_rotation) == Vector3(0, 180, 0):
			direction.z -= 1
			print(camera_rotation)
		elif round(camera_rotation) == Vector3(0, 270, 0):
			direction.x -= 1
			print(camera_rotation)
		elif round(camera_rotation) == Vector3(0, -90, 0):
			direction.x -= 1
			print(camera_rotation)
		elif round(camera_rotation) == Vector3(0, -180, 0):
			direction.z -= 1
			print(camera_rotation)
		elif round(camera_rotation) == Vector3(0, -270, 0):
			direction.x += 1
	elif Input.is_action_just_pressed("move_forward"):
		if camera_rotation == Vector3(0, 0, 0):
			direction.z -= 1
			print(camera_rotation)
		elif camera_rotation == Vector3(0, 90, 0):
			direction.x -= 1
			print(camera_rotation)
		elif camera_rotation == Vector3(0, 180, 0):
			direction.z += 1
			print(camera_rotation)
		elif camera_rotation == Vector3(0, 270, 0):
			direction.x += 1
			print(camera_rotation)
		elif camera_rotation == Vector3(0, -90, 0):
			direction.x +=1
			print(camera_rotation)
		elif camera_rotation == Vector3(0, -180, 0):
			direction.z += 1
			print(camera_rotation)
		elif camera_rotation == Vector3(0, -270, 0):
			direction.x -= 1
			print(camera_rotation)
	
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
