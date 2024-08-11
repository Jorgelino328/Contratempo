extends Node3D
var state = 1

func _on_spikes_body_entered(body):
	if body is Player:
		body.hp -= 3


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
