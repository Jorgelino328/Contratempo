extends Level

@onready var start_song = load("res://Assets/Audio/Satus.ogg")
@onready var run_song = load("res://Assets/Audio/Run.ogg")
@onready var intro = "res://Assets/Dialogue/Intro.json"
@onready var device = $Temple/Device

var playing = false
var has_shaked = false
var outside = true

signal dialogue(json)

func _process(delta):
	super._process(delta)
	if(!playing && !has_shaked):
		emit_signal("change_song",start_song)
		emit_signal("dialogue",intro)
		
		playing = true
		
		
	if(!device && !has_shaked):
		has_shaked = true
		begin_earthquake()
		
func begin_earthquake():
	$Temple.change_state(2)
	$Cameras/PlayerCamera/Timer.start()
	$Cameras/PlayerCamera/EarthquakeSound.play()
	emit_signal("change_song",run_song)	
	
func stop_earthquake():
	$Cameras/PlayerCamera/Timer.stop()
	$Cameras/PlayerCamera/EarthquakeSound.stop()
	
func use_rain():
	super.use_rain()
	$Temple.use_rain()
	if(outside && $Timer.is_stopped):
		$Timer.start()
	
func use_sun():
	super.use_sun()
	$Temple.use_sun()
	if(!$Timer.is_stopped):
		$Timer.stop()

func use_clear():
	super.use_clear()
	if(!$Timer.is_stopped):
		$Timer.stop()
		
func _on_camera_1_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera1.make_current()
		outside = true
		current_camera = $Cameras/Camera1

func _on_camera_2_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera2.make_current()
		outside = true
		current_camera = $Cameras/Camera2

func _on_camera_3_trigger_body_entered(body):
	if(body is Player):
		$Cameras/Camera3.make_current()
		current_camera = $Cameras/Camera3
		outside = false
		player.set_camera_type(0)
		if(!$Cameras/PlayerCamera/Timer.is_stopped()):
			stop_earthquake()

func _on_camera_4_trigger_body_entered(body):
	if(body is Player):
		$Cameras/PlayerCamera.make_current()
		outside = false
		current_camera = $Cameras/PlayerCamera
		player.set_camera_type(1)

func _on_room_1_body_entered(body):
	$Temple.room = 1

func _on_room_2_body_entered(body):
	$Temple.room = 2

func _on_timer_timeout():
	if ($Fire.get_child(0)):
		$Fire.get_child(0).queue_free()
