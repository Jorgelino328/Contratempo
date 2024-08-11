extends Node3D
@export var state = 1

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
		print("let it rain!")
		$TempleRoom2.raise_or_lower_water()
