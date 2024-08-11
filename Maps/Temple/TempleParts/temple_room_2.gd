extends Node3D

@export var final_pos : Vector3
var state = 1

func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") && state == 1):
		state = 2
		print(state)
	elif (Input.is_action_just_pressed("ui_accept") && state == 2):
		state = 1
		print(state)
	match state:
		1:
			pass
		2:
			if($MovingPlatform.floating):
				$MovingPlatform.floating = false
				$MovingPlatform.position = Vector3(3,0,24.5)
			if(!$Water.rising):
				$Water.rising = true
			
			

func _on_hide_right_body_entered(body):
	if(body is Player):
		$Walls/WallRight.visible = false

func _on_hide_right_body_exited(body):
	if(body is Player):
		$Walls/WallRight.visible = true
	
func _on_hide_left_body_entered(body):
	if(body is Player):
		$Walls/WallLeft.visible = false

func _on_hide_left_body_exited(body):
	if(body is Player):
		$Walls/WallLeft.visible = true

func _on_hide_middle_body_entered(body):
	if(body is Player):
		$Walls/WallMiddle.visible = false

func _on_hide_middle_body_exited(body):
	if(body is Player):
		$Walls/WallMiddle.visible = true
