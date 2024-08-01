extends CharacterBody3D

@export var speed = 8
@export var fall_acceleration = 75
@onready var animation = $Model/AnimationPlayer
@onready var press_timer = $Timer

enum status {IDLE, JUMP_DOWN, JUMP_STILL, LONG_JUMP, RUNNING, START_WALK, WALKING}

var target_velocity = Vector3.ZERO
var player_status = status.IDLE
var can_run = false

func _physics_process(delta):
	var input_dir =  Input.get_vector("up","down","right","left",)
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity = direction * speed
	rotation.y = atan2(velocity.x,velocity.z)
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	move_and_slide()
	animation_handler(direction)
	
	
func animation_handler(direction):
	if(direction == Vector3.ZERO && is_on_floor()):
		if Input.is_action_just_pressed("jump"):
			player_status = status.JUMP_STILL
		else:
			player_status = status.IDLE
	elif (direction != Vector3.ZERO && is_on_floor()):
		if Input.is_action_just_pressed("jump"):
			player_status = status.LONG_JUMP
		else:
			if Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right"):
				if can_run:
					player_status = status.RUNNING
				else:
					player_status = status.WALKING
					can_run = true
					press_timer.start()
	match (player_status):
			status.IDLE:
				animation.play("Idle")
			status.JUMP_DOWN:
				animation.play("Jump_Down")
			status.JUMP_STILL:
				animation.play("Jump_Still")
			status.LONG_JUMP:
				animation.play("Long_Jump")
			status.RUNNING:
				animation.play("Running")
			status.START_WALK:
				animation.play("Start_Walk")
			status.WALKING:
				animation.play("Walking")


func _on_timer_timeout():
	can_run = false;
