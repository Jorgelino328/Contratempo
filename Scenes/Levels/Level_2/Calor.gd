extends Level

var fireStatus = 0
var fireOn = false

func _process(delta):
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
	
