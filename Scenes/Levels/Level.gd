class_name Level extends Node3D
@export var player: Node3D

@onready var cameras = $Cameras.get_children()

var current_camera: Camera3D = null
var game_over = load("res://Scenes/UIs/Game_Over/Game_Over.tscn")
var settings = load("res://Scenes/UIs/Menus/Settings/Settings.tscn")
var dialogueUI = preload("res://Scenes/UIs/Dialogue_UI/Dialogue_UI.tscn")
var paused = false

signal next_level(level)
signal change_song(new_song)

func _ready():
	if player == null or cameras.is_empty():
		print("Player or cameras not set.")
	update_closest_camera()

func pause():
	var settings_instance = settings.instantiate()
	$CanvasLayer.add_child(settings_instance)
	paused = true
	get_tree().paused = true
	
func _process(delta):
	update_closest_camera()
	#if Input.is_action_just_released("esc"):
		#if(!paused):
			#pause()
		#elif(paused):
			#get_tree().paused = false
			#paused = false
			#$CanvasLayer/Settings.queue_free()
			
	#if($Player.hp <= 0 && $Player.dead):
		#emit_signal("next_level",game_over)
		
func update_closest_camera():
	var closest_camera = null
	var closest_distance = INF

	for camera in cameras:
		if camera is Camera3D:
			var distance = player.global_transform.origin.distance_to(camera.global_transform.origin)
			
			if distance < closest_distance:
				closest_distance = distance
				closest_camera = camera

	if closest_camera != current_camera:
		if current_camera:
			current_camera.current = false  
		if closest_camera:
			closest_camera.current = true  
		current_camera = closest_camera
