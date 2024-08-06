extends Node3D

var body_inside = null
	
func _on_hit_box_body_entered(body):
	if body is Player:
		$Timer.start()
		body_inside = body

func _on_hit_box_body_exited(body):
	if body is Player:
		$Timer.stop()
		body_inside = null

func _on_timer_timeout():
	if body_inside:
		body_inside.hp -= 1
