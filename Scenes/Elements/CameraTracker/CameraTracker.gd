extends Camera3D
@onready var cast = $ShapeCast3D
var on_screen = false

func _process(delta):
	for obj in cast.collision_result:
		if(obj.collider is Player):
			on_screen = true
