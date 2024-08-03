extends CharacterBody3D

@export var walk_speed = 4
@export var running_speed = 6
@export var fall_acceleration = 30
@export var jump_impulse = 10
@export var rotation_speed = 10
 
var current_speed = walk_speed
@onready var animTree : AnimationTree = $AnimationTree
@onready var press_timer : Timer  = $Timer

var target_velocity = Vector3.ZERO
var last_action : String
var can_run = false

func _physics_process(delta):
	var input_dir = Input.get_vector("down", "up", "left", "right")
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()

	for action in ["up", "down", "left", "right"]:
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
	

	velocity = direction * current_speed + target_velocity
	
	if(velocity != Vector3.ZERO):
		rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), rotation_speed * delta)
		
	move_and_slide()
	update_animation(direction)

func update_animation(direction):
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
			if(Input.is_action_pressed("jump")):
				animTree["parameters/conditions/jumping_long"] = true
			else:
				animTree["parameters/conditions/jumping_long"] = false
		else:
			current_speed = walk_speed
			animTree["parameters/conditions/walking"] = true
			animTree["parameters/conditions/running"] = false
