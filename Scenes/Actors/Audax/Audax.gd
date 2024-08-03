class_name Player extends CharacterBody3D

@export var walk_speed = 4
@export var running_speed = 6
@export var fall_acceleration = 30
@export var jump_impulse = 10
@export var rotation_speed: float = 5.0
var max_rotation : float = deg_to_rad(90)
var min_rotation : float = deg_to_rad(-90)
var current_rotation : float = 0.0
 
var current_speed = walk_speed
@onready var animTree : AnimationTree = $AnimationTree
@onready var press_timer : Timer  = $Timer

var target_velocity = Vector3.ZERO
var can_run = false

func _physics_process(delta):
	handle_movement(delta)
	move_and_slide()
	update_animation()
	
func handle_movement(delta):
	var move_direction: Vector3 = Vector3.ZERO
	var rotation_direction: float = 0.0
	if Input.is_action_pressed("forward"):
		move_direction = transform.basis.z
	if Input.is_action_pressed("right"):
		rotation_direction -= 1.0
	if Input.is_action_pressed("left"):
		rotation_direction += 1.0
	if rotation_direction != 0.0:
		rotate_y(rotation_direction * rotation_speed * delta)
	
	if Input.is_action_just_pressed("backwards"):
		rotate_y(deg_to_rad(180))
		current_rotation += deg_to_rad(180)
		current_rotation = wrapf(current_rotation, -PI, PI)
	elif Input.is_action_just_pressed("forward"):
		if(!press_timer.is_stopped()):
			can_run = true
		else:
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
			target_velocity.z = walk_speed * move_direction.z	
		
	velocity = move_direction * current_speed + target_velocity

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
			if(Input.is_action_pressed("jump")):
				animTree["parameters/conditions/jumping_long"] = true
			else:
				animTree["parameters/conditions/jumping_long"] = false
		else:
			current_speed = walk_speed
			animTree["parameters/conditions/walking"] = true
			animTree["parameters/conditions/running"] = false
