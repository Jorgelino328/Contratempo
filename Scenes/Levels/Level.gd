class_name Level extends Node3D
@export var player: Player
@export var cameras : Node3D
@export var current_camera : Camera3D

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
	#if Input.is_action_just_released("esc"):
		#if(!paused):
			#pause()
		#elif(paused):
			#get_tree().paused = false
			#paused = false
			#$CanvasLayer/Settings.queue_free()
			#
	if(player.hp <= 0):
		emit_signal("next_level",game_over)
		
func use_rain():
	pass
