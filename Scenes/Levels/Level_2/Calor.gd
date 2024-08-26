extends Level
var intro_dialogue = "res://Assets/Dialogue/Intro2.json"
var plant_dialogue = "res://Assets/Dialogue/Planta.json"
var device_dialogue = "res://Assets/Dialogue/Capacitor.json"
var end_game = load("res://Scenes/UIs/End/EndGame.tscn")
var plantDone = false
var deviceDone = false
var fireStatus = 0
var fireOn = false
	
func _process(delta):
	super._process(delta)
	match fireStatus:
		0:
			if $FireRiver/River.transform.origin.y <= $FireRiver/River.start_position.y && !fireOn:
				fireOn = true
				fireStatus = 1
			elif $FireRiver/River.transform.origin.y >= $FireRiver/River.end_position.y && fireOn:
				fireOn = false
				fireStatus = 2
		1:
			$FireRiver.light_fire()
			fireStatus = 0
		2:
			$FireRiver.put_out_fire()
			fireStatus = 0
		

func use_rain():
	super.use_rain()
	$FireRiver.raise_water()
	$FireRiver.activate_pillars(1)
	

func use_sun():
	super.use_sun()
	$FireRiver.lower_water()
	$FireRiver.activate_pillars(2)
	

func _on_device_pickup(body):
	if body is Player:
		emit_signal("next_level",end_game)


func _on_timer_timeout():
	emit_signal("dialogue",intro_dialogue)

func _on_device_area_see_body_entered(body):
	if body is Player && !deviceDone:
		emit_signal("dialogue",device_dialogue)
		deviceDone = true
		
func _on_flower_area_body_entered(body):
	if body is Player && !plantDone:
		emit_signal("dialogue",plant_dialogue)
		plantDone = true
