class_name Level extends Node3D
@export var player: Player
@export var current_camera: Camera3D

@onready var cameras = $Cameras.get_children()

var game_over = load("res://Scenes/UIs/Game_Over/Game_Over.tscn")
var settings = load("res://Scenes/UIs/Menus/Settings/Settings.tscn")
var dialogueUI = preload("res://Scenes/UIs/Dialogue_UI/Dialogue_UI.tscn")
var paused = false

signal next_level(level)
signal change_song(new_song)

func pause():
	var settings_instance = settings.instantiate()
	$CanvasLayer.add_child(settings_instance)
	paused = true
	get_tree().paused = true
	
func _process(delta):
	#print(current_camera.global_transform.origin.distance_to(player.global_transform.origin))
	if(current_camera.global_transform.origin.distance_to(player.global_transform.origin) > 10):
		update_camera()
	#if Input.is_action_just_released("esc"):
		#if(!paused):
			#pause()
		#elif(paused):
			#get_tree().paused = false
			#paused = false
			#$CanvasLayer/Settings.queue_free()
			
	#if($Player.hp <= 0 && $Player.dead):
		#emit_signal("next_level",game_over)
		
func update_camera():
	var valid_cameras = []
	var best_camera = current_camera
	
	for camera in cameras:
		if camera.on_screen:
			valid_cameras.push_back(camera)
			
	for camera in valid_cameras:
		var distance = camera.global_transform.origin.distance_to(player.global_transform.origin)
		var closest_distance = best_camera.global_transform.origin.distance_to(player.global_transform.origin)
		if distance < closest_distance:
			best_camera = camera
			
	current_camera = best_camera
	current_camera.make_current()
