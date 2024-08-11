extends Level

@onready var new_song = load("res://Assets/Audio/Satus.ogg")

var playing = false
var has_shaked = false

func _process(delta):
	super._process(delta)
	
	if(!playing):
		emit_signal("change_song",new_song)
		playing = true
		
	if(!$Temple/Device && !has_shaked):
		has_shaked = true
		begin_earthquake()
		
func begin_earthquake():
	$Temple.change_state(2)
	$Cameras/PlayerCamera/Timer.start()
	$Cameras/PlayerCamera/EarthquakeSound.play()
	
func stop_earthquake():
	$Cameras/PlayerCamera/Timer.stop()
	$Cameras/PlayerCamera/EarthquakeSound.stop()
	
func use_rain():
	super.use_rain()
	$Temple.use_rain()
	
func _on_camera_1_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera1.make_current()
		current_camera = $Cameras/Camera1

func _on_camera_2_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera2.make_current()
		current_camera = $Cameras/Camera2

func _on_camera_3_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera3.make_current()
		current_camera = $Cameras/Camera3
		player.set_camera_type(0)
		if(!$Cameras/PlayerCamera/Timer.is_stopped()):
			stop_earthquake()

func _on_camera_4_trigger_body_entered(body):
	if(body is Player):
		$Cameras/PlayerCamera.make_current()
		current_camera = $Cameras/PlayerCamera
		player.set_camera_type(1)
