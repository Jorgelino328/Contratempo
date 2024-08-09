extends Node3D

@export var start_position : Vector3
@export var end_position : Vector3
@export var speed : float = 5.0

var direction : int = 1

func _ready():
	transform.origin = start_position

func _process(delta):
	transform.origin.z += speed * direction * delta

	if direction == 1 and transform.origin.z >= end_position.z:
		direction = -1
	elif direction == -1 and transform.origin.z <= start_position.z:
		direction = 1

	transform.origin.z = transform.origin.z + (speed * direction * delta)


func _on_area_3d_body_entered(body):
	if body is Player:
		body.on_platform = self

func _on_area_3d_body_exited(body):
	if body is Player:
		body.on_platform = null


func _on_hide_right_body_entered(body):
	$Walls/WallRight.visible = false

func _on_hide_right_body_exited(body):
	$Walls/WallRight.visible = true
	
func _on_hide_left_body_entered(body):
	$Walls/WallLeft.visible = false

func _on_hide_left_body_exited(body):
	$Walls/WallLeft.visible = true

func _on_hide_middle_body_entered(body):
	$Walls/WallMiddle.visible = false

func _on_hide_middle_body_exited(body):
	$Walls/WallMiddle.visible = true


