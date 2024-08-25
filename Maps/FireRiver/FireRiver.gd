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
		

func light_fire():
	emit_signal("lightUp")
	
func put_out_fire():
	emit_signal("lightDown")
