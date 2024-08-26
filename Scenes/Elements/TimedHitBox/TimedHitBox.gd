extends Area3D
var body_inside = null

func _on_timer_timeout():
	if body_inside:
		body_inside.hp -= 1


func _on_body_entered(body):
	if body is Player:
		$Timer.start()
		body_inside = body


func _on_body_exited(body):
	if body is Player:
		$Timer.stop()
		body_inside = null
