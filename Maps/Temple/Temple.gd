extends Node3D
@export var state = 1
@export var room = 0

func _ready():
	$TempleRoom1.state = state
	$TempleRoom2.state = state

func change_state(new_state):
	state = new_state
	if($TempleRoom1.state != state || $TempleRoom2.state != state):
			$TempleRoom1.state = state
			$TempleRoom2.state = state

func use_rain():
	if state == 2:
		match room:
			1:
				$TempleRoom1.raise_water()
			2:
				$TempleRoom2.raise_water()
		
func use_sun():
	if state == 2:
		match room:
			1:
				$TempleRoom1.melt_spikes()
				$TempleRoom1.lower_water()
			2:
				$TempleRoom2.lower_water()
		
