extends Level

@onready var new_song = load("res://Assets/Audio/Satus.ogg")
var playing = false

func _process(delta):
	super._process(delta)
	if(!playing):
		emit_signal("change_song",new_song)
		playing = true
				
func _on_camera_1_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera1.make_current()
		update_camera()

func _on_camera_2_trigger_body_entered(body):

	if(body is Player):
		$Cameras/Camera2.make_current()
		update_camera()

func _on_camera_3_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera3.make_current()
		update_camera()

func _on_camera_4_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera4.make_current()
		update_camera()

func _on_camera_5_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera5.make_current()
		update_camera()

func _on_camera_6_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera6.make_current()
		update_camera()
