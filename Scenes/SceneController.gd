extends Node
@onready var dialogue_UI := load("res://Scenes/UIs/Dialogue_UI/Dialogue_UI.tscn")
@onready var current_level := $Main_Menu

var previous_camera : Camera3D
var reload := false

signal dialogue_stopped_lvl() 

func _ready():
	connect_signals()
	$Audio/BackgroundMusic.play()

func connect_signals():
	if(current_level == $Game_Over || current_level == $EndGame):
		current_level.menu.connect(_on_menu)
		current_level.quit.connect(_on_quit)
	elif(current_level == $Next_Level):
		current_level.next_level.connect(_on_next_level)
		current_level.menu.connect(_on_menu)
		current_level.quit.connect(_on_quit)
	elif(current_level == $Main_Menu):
		current_level.new_game.connect(_on_main_menu_new_game)
		current_level.settings.connect(_on_main_menu_settings)
		current_level.quit.connect(_on_quit)
	elif(current_level == $Settings):
		current_level.back_menu.connect(_on_settings_back_menu)
	else:
		current_level.connect_signals()
		current_level.next_level.connect(_on_next_level)
		current_level.level_screen.connect(level_screen)
		current_level.change_song.connect(_on_change_song)
		current_level.change_weather.connect(_on_change_weather)
		current_level.dialogue.connect(_on_dialogue)

func _on_dialogue(json_path):
	var dialogue_inst = dialogue_UI.instantiate()
	dialogue_inst.dialoguePath = json_path
	dialogue_inst.dialogue_stop.connect(_on_dialogue_stop)
	dialogue_inst.caaat.connect(_on_caaat)
	dialogue_inst.cat_over.connect(_on_cat_over)
	add_child(dialogue_inst)
	get_tree().paused = true
	
func _on_dialogue_stop():
	$Timer.start()
	
func _on_caaat(run):
	previous_camera = current_level.current_camera
	current_level.get_node("Cameras").get_node("CatCam").make_current()
	current_level.current_camera = current_level.get_node("Cameras").get_node("CatCam")
	if run:
		if(current_level.get_node("CatPath2").get_child_count() > 0):
			current_level.get_node("CatPath2").get_node("Follow").run = true
		else:
			current_level.get_node("CatPath").get_node("Follow").drop = true
			current_level.get_node("CatPath").get_node("Follow").run = true
			
func _on_cat_over():
	current_level.current_camera = previous_camera
	previous_camera.make_current()

func _on_change_song(new_song):
	$Audio/BackgroundMusic.stream = new_song
	$Audio/BackgroundMusic.play()

func _on_change_weather(new_weather):
	if(new_weather):
		var weather_instance = new_weather.instantiate()
		for i in $Weather.get_children():
			i.queue_free()
		$Weather.add_child(weather_instance)
	else:
		for i in $Weather.get_children():
			i.queue_free()
			
func _on_next_level(level):
	var next_level = level.instantiate()
	change_level(next_level)

func _on_main_menu_new_game():
	var next_level = load("res://Scenes/Levels/Level_1/Satus.tscn").instantiate()
	#var next_level = load("res://Scenes/Levels/Level_2/Calor.tscn").instantiate()
	change_level(next_level)
	
func _on_settings_back_menu():
	var next_level = load("res://Scenes/UIs/Menus/Main_Menu/main_menu.tscn").instantiate()
	change_level(next_level)

func _on_main_menu_settings():
	var next_level = load("res://Scenes/UIs/Menus/Settings/Settings.tscn").instantiate()
	change_level(next_level)

func _on_quit():
	get_tree().quit()

func _on_menu():
	var next_level = load("res://Scenes/UIs/Menus/Main_Menu/main_menu.tscn").instantiate()
	change_level(next_level)
	
func change_level(next_level):
	add_child(next_level)
	current_level.queue_free()
	current_level = next_level
	connect_signals()
	
func level_screen(next_level):
	var lvl_screen = load("res://Scenes/UIs/Next_Level/Next_Level.tscn").instantiate()
	add_child(lvl_screen)
	current_level.queue_free()
	current_level = lvl_screen
	current_level.level = next_level
	connect_signals()
	
func _on_timer_timeout():
	get_tree().paused = false
	emit_signal("dialogue_stopped_lvl")
	
