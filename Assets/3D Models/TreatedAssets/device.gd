extends Node3D

signal device_picked()

func _on_area_3d_body_entered(body):
	if body is Player and visible:
		$PickedUp.play()
		body.has_device = true
		visible = false
		
func _on_picked_up_finished():
	emit_signal('device_picked')
	queue_free()
