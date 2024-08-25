extends Node3D

signal lightUp()
signal lightDown()

func _ready():
	var parent = get_parent()
	parent.lightUp.connect(_on_lightUp)
	parent.lightDown.connect(_on_lightDown)

func _on_lightUp():
	emit_signal("lightUp")
	
func _on_lightDown():
	emit_signal("lightDown")
