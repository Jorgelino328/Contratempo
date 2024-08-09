extends Node3D


func _on_hide_right_body_entered(body):
	$Walls/WallRight.visible = false

func _on_hide_right_body_exited(body):
	$Walls/WallRight.visible = true
	
func _on_hide_left_body_entered(body):
	$Walls/WallLeft.visible = false

func _on_hide_left_body_exited(body):
	$Walls/WallLeft.visible = true

func _on_hide_middle_body_entered(body):
	$Walls/WallMiddle.visible = false

func _on_hide_middle_body_exited(body):
	$Walls/WallMiddle.visible = true
