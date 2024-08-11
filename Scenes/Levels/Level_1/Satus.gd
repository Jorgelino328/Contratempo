extends Level

@onready var start_song = load("res://Assets/Audio/Satus.ogg")
@onready var run_song = load("res://Assets/Audio/Run.ogg")
@onready var intro = "res://Assets/Dialogue/Intro.json"
@onready var fire = "res://Assets/Dialogue/Fire.json"
@onready var fire_hint = "res://Assets/Dialogue/FireRain.json"
@onready var find_device = "res://Assets/Dialogue/FindDevice.json"
@onready var device_picked = "res://Assets/Dialogue/DevicePicked.json"
@onready var earthquake_dialogue = "res://Assets/Dialogue/EarthquakeStarts.json"
@onready var device = $Temple/Device

var intro_started = false
var fire_started = false
var outside = true
var has_device = false
var earthquake = false

signal dialogue(json)

func _process(delta):
	super._process(delta)
	if(!intro_started):
		emit_signal("change_song",start_song)
		emit_signal("dialogue",intro)
		intro_started = true
		
func connect_signals():
	super.connect_signals()
	device.device_picked.connect(_on_device_picked)
	
func _on_device_picked():
	has_device = true
	emit_signal("dialogue",device_picked)
	
func _on_dialogue_stop():
	super._on_dialogue_stop()
	if(intro_started && !fire_started):
		$Fire.visible = true
		$Fire/FireSound.play()
		emit_signal("dialogue",fire)
		fire_started = true
	elif(has_device && !earthquake):
		begin_earthquake()
		
func begin_earthquake():
	$Temple.change_state(2)
	$Cameras/PlayerCamera/Timer.start()
	$Cameras/PlayerCamera/EarthquakeSound.play()
	$Tutorial3.visible = true
	$Tutorial3.position.y = 1.718
	earthquake = true
	$QuakeTimer.start()
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
		if(fire_started && $Fire.get_child_count() > 0 && $HintCooldown.is_stopped()):
			emit_signal("dialogue",fire_hint)
			


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
	$Cameras/CatCam.position = Vector3(56.357,2.996,54.053)
	$Cameras/CatCam.rotation = Vector3(-0.8,-0.5,0)

func _on_timer_timeout():
	if ($Fire.get_child_count() > 0):
		$Fire.get_child(0).queue_free()


func _on_room_3_body_entered(body):
	emit_signal("dialogue",find_device)
	$Room3.queue_free()


func _on_quake_timer_timeout():
	emit_signal("dialogue",earthquake_dialogue)
