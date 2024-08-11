class_name floater extends RigidBody3D

@export var float_force := 1.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05
@export var max_rotation_angle = 10

@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var water : MeshInstance3D

@onready var probes = $ProbeContainer.get_children()

var submerged := false

func _physics_process(delta):
	if water:
		submerged = false
		for p in probes:
			var depth = water.global_position.y - p.global_position.y 
			if depth > 0:
				submerged = true
				apply_force(Vector3.UP * float_force * gravity * depth, p.global_position - global_position)
	
func _integrate_forces(state: PhysicsDirectBodyState3D):
	if submerged:
		state.linear_velocity *=  1 - water_drag
		state.angular_velocity = clamp_angle(state.angular_velocity)
		
func clamp_angle(a_vel):
	return Vector3(0,clamp(a_vel.y * 1 - water_angular_drag,-0.3,0.3),0)
	
