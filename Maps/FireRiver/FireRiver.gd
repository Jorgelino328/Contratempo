extends Node3D

signal lightUp()
signal lightDown()

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

func light_fire():
	emit_signal("lightUp")
	
func put_out_fire():
	emit_signal("lightDown")


func _on_area_3d_area_entered(area):
	pass # Replace with function body.
