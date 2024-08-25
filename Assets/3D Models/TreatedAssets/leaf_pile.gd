extends Node3D
@export var state = 1

func _ready():
	var parent = get_parent()
	parent.lightUp.connect(_on_lightUp)
	parent.lightDown.connect(_on_lightDown)
	
func _process(delta):
	match state:
		1:
			$Flame.visible = false
			$Flame/HitBox/CollisionShape3D.disabled = true
			state = 0
		2:
			$Flame.visible = true
			$Flame/HitBox/CollisionShape3D.disabled = false
			state = 0

func _on_lightUp():
	state = 2

func _on_lightDown():
	state = 1

