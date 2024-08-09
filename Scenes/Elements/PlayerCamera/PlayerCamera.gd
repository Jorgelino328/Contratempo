extends Node3D

@export var player: CharacterBody3D
@export var offset: Vector3 = Vector3(0, 5, 4)
@export var shake_intensity: float = 0.1

func _process(delta):
	var target_position = player.position + offset
	global_transform.origin = target_position
	if !$Timer.is_stopped():
		var shake_amount = Vector3(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		global_transform.origin += shake_amount
