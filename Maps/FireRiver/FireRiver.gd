extends Node3D

signal lightUp()
signal lightDown()

func _process(delta):
	if $Lever.on == true:
		activate_pillars(3)
		$River.start_position.y = -10
		$River/FullRiver.visible = true

func raise_water():
	if(!$River.rising):
		$River.rising = true
		$River.draining = false


func lower_water():
	if(!$River.draining):
		$River.rising = false
		$River.draining = true
		
func activate_pillars(n):
	match n:
		1:
			$Pillar1.lit = true
			$Pillar2.lit = false
		2:
			$Pillar1.lit = false
			$Pillar2.lit = true
		3:
			$Pillar1.lit = false
			$Pillar2.lit = false

func light_fire():
	emit_signal("lightUp")
	
func put_out_fire():
	emit_signal("lightDown")
