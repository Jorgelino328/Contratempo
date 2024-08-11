extends Node3D
var state = 1
var broken_ramp = false

func _process(delta):
	if (state == 2 && !broken_ramp):
		$Ramp.visible = true
		$Ground/FirstWall.queue_free()
		broken_ramp = true		
		
func _on_spikes_body_entered(body):
	if body is Player:
		body.hp -= 3

func raise_water():
	if(!$Water.rising):
		$Water.end_position.y = -0.8
		$Water.rising = true
		$Water.draining = false
		
func lower_water():
	if(!$Water.draining):
		$Water.rising = false
		$Water.draining = true
		
func melt_spikes():
	if(!$Spikes.melting):
		$Spikes.melting = true

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
