extends Node3D

@export var start_position : Vector3
@export var end_position : Vector3
@export var speed : float = 1.0
var melting = false

func _process(delta):
	if melting and transform.origin.y > start_position.y:
		transform.origin.y += speed * -1 * delta
		transform.origin.y = transform.origin.y + (speed * -1 * delta)
		if(!get_parent().get_node("Water").rising):
			get_parent().get_node("Water").end_position.y = -3.25
			get_parent().get_node("Water").rising = true
			get_parent().get_node("Water").draining = false
	
