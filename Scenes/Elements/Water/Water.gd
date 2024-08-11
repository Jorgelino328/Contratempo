extends Node3D

@export var start_position : Vector3
@export var end_position : Vector3
@export var speed : float = 1.0
var rising = false
var draining = false

func _ready():
	transform.origin = start_position

func _process(delta):
	if rising and transform.origin.y < end_position.y:
		move(1,delta)
	elif draining and transform.origin.y > start_position.y:
		move(-1,delta)
		
func move(direction,delta):
	transform.origin.y += speed * direction * delta
	transform.origin.y = transform.origin.y + (speed * direction * delta)
