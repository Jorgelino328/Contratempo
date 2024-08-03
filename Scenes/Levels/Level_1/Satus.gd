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


func _on_camera_2_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera2.make_current()


func _on_camera_3_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera3.make_current()
