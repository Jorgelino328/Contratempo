extends Node3D

func _on_hide_middle_body_entered(body):
	$Walls/WallMiddle.visible = false

func _on_hide_middle_body_exited(body):
	$Walls/WallMiddle.visible = true
