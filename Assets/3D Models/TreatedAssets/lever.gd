extends Node3D
var player_inside : Player
var on = false

func _process(delta):
	if player_inside != null:
		if Input.is_action_just_pressed("interact"):
			if on:
				$AnimationPlayer.play("TurnOff")
				on = false
			else:
				$AnimationPlayer.play("TurnOn")
				on = true
				

func _on_lever_body_entered(body):
	if body is Player:
		player_inside = body


func _on_lever_body_exited(body):
	if body is Player:
		player_inside = null
