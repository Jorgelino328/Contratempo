extends Node3D
@export var tutorial : String

func _on_area_3d_body_entered(body):
	if (body is Player):
		get_parent().emit_signal("dialogue",tutorial)
