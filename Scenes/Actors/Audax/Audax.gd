class_name Player extends CharacterBody3D

@export var hp = 3
@export var charges = 3
@export var has_device = false
@export var walk_speed = 4
@export var running_speed = 6
@export var fall_acceleration = 30
@export var jump_impulse = 10
@export var rotation_speed: float = 5.0

@onready var animTree : AnimationTree = $AnimationTree
@onready var press_timer : Timer  = $Timer

enum {BACKVIEW, SIDEVIEW, TOPDOWN }

var max_rotation : float = deg_to_rad(90)
var min_rotation : float = deg_to_rad(-90)
var current_rotation : float = 0.0
var current_speed = walk_speed
var last_action : String
var target_velocity = Vector3.ZERO
var camera_type = BACKVIEW
var can_run = false
var on_platform : Node3D = null

func _process(delta):
	if(has_device):
		if Input.is_action_just_pressed("water"):
			get_parent().use_rain()
			
func _physics_process(delta):
	handle_movement(delta)
	update_animation()
	move_and_slide()
	if on_platform:
		global_transform.origin += on_platform.global_transform.basis.z * (2*on_platform.speed * on_platform.direction * delta)
	
func handle_movement(delta):
	var input_dir = Input.get_vector("left", "right","forward","backwards")
	var direction = get_direction(input_dir)
	
	for action in ["forward", "backwards", "left", "right"]:
		if Input.is_action_just_pressed(action):
			if(action == last_action && !press_timer.is_stopped()):
				can_run = true
			else:
				last_action = action
				press_timer.start()

	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta
	else:
		target_velocity.y = 0
		target_velocity.z = 0
		var jump_time = animTree["parameters/Jump_Still/time"]
		var long_jump_time = animTree["parameters/Long_Jump/time"]
		if (jump_time != null && jump_time > 0.8 && jump_time < 0.9):
			target_velocity.y = jump_impulse
		elif (long_jump_time != null && long_jump_time > 0 && long_jump_time < 0.1):
			target_velocity.y = jump_impulse
			target_velocity.z = walk_speed * direction.z 
		elif (jump_time != null && jump_time < 0.8):
			direction = Vector3.ZERO
	
	if on_platform:
		target_velocity.z *= on_platform.speed * on_platform.direction
		
	velocity = direction * current_speed + target_velocity
	
	if(velocity != Vector3.ZERO && is_on_floor()):
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), rotation_speed * delta)

func update_animation():
	if(velocity == Vector3.ZERO):
		can_run = false
		animTree["parameters/conditions/idle"] = true
		animTree["parameters/conditions/walking"] = false
		animTree["parameters/conditions/running"] = false
		if(Input.is_action_just_pressed("jump")):
			animTree["parameters/conditions/jumping_still"] = true
		else:
			animTree["parameters/conditions/jumping_still"] = false
	else:
		animTree["parameters/conditions/idle"] = false
		if(can_run):
			current_speed = running_speed
			animTree["parameters/conditions/running"] = true
			animTree["parameters/conditions/walking"] = false
			if(Input.is_action_just_pressed("jump")):
				animTree["parameters/conditions/jumping_long"] = true
			else:
				animTree["parameters/conditions/jumping_long"] = false
		else:
			current_speed = walk_speed
			animTree["parameters/conditions/walking"] = true
			animTree["parameters/conditions/running"] = false

func set_camera_type(new_camera):
	camera_type = new_camera
	
func get_direction(input_dir):
	match camera_type:
		BACKVIEW:
			return Vector3(input_dir.x, 0.0, input_dir.y).rotated(Vector3.UP, get_parent().current_camera.rotation.y).normalized()
		SIDEVIEW:
			return Vector3(input_dir.x, 0.0, input_dir.y).rotated(Vector3.UP, get_parent().current_camera.rotation.x).normalized()
		TOPDOWN:
			return Vector3(input_dir.y, 0.0, -input_dir.x).rotated(Vector3.UP, get_parent().current_camera.rotation.z).normalized()
	

