extends Node3D

@export var player: CharacterBody3D
@export var offset: Vector3 = Vector3(0, 5, 4)

func _process(delta):
	var target_position = player.position + offset
	global_transform.origin = target_position
	
