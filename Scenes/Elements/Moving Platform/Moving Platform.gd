extends Node3D

@export var start_position : Vector3
@export var end_position : Vector3
@export var speed : float = 5.0
@export var water : MeshInstance3D

@onready var static_platform = $StaticPlatform

var floating = true 
var direction : int = 1

func _ready():
	transform.origin = start_position
	if(water):
		$Platform.water = water

func _physics_process(delta):
	if(floating):
		transform.origin.z += speed * direction * delta

		if direction == 1 and transform.origin.z >= end_position.z:
			direction = -1
		elif direction == -1 and transform.origin.z <= start_position.z:
			direction = 1

		transform.origin.z = transform.origin.z + (speed * direction * delta)
	else:
		if static_platform && $Area3D/CollisionShape3D.disabled == false:
			$Platform.mass = 1
			$Platform.gravity_scale = 1
			static_platform.queue_free()
			$Area3D/CollisionShape3D.disabled = true
		
func _on_area_3d_body_entered(body):
	if body is Player:
		body.on_platform = self

func _on_area_3d_body_exited(body):
	if body is Player:
		body.on_platform = null



