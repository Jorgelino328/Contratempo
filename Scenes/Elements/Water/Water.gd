extends Node3D

@export var start_position : Vector3
@export var end_position : Vector3
@export var speed : float = 1.0
var rising = false

func _ready():
	transform.origin = start_position

func _process(delta):
	if rising and transform.origin.y < end_position.y:
		transform.origin.y += speed * delta
		transform.origin.y = transform.origin.y + (speed * delta)
