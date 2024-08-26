extends StaticBody3D

@export var start_position : Vector3
@export var end_position : Vector3
@export var speed : float = 5.0
@export var lit = true
func _physics_process(delta):
	if lit:
		if transform.origin.y <= end_position.y:
			transform.origin.y += speed * delta
			transform.origin.y = transform.origin.y + (speed * delta)
		else:
			$Flame.visible = true
			$Flame/HitBox/CollisionShape3D.disabled = false
	else:
		if $Flame.visible :
			$Flame.visible = false
			$Flame/HitBox/CollisionShape3D.disabled = true
		if transform.origin.y >= start_position.y:
			transform.origin.y -= speed * delta
			transform.origin.y = transform.origin.y + (speed * delta * -1)
			
