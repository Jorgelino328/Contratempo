extends Control
signal menu()
signal quit()
signal next_level(level)
var level = preload("res://Scenes/Levels/Level_2/Calor.tscn")


func _on_btn_quit_pressed():
	emit_signal("quit")

func _on_btn_menu_pressed():
	emit_signal("menu")

func _on_btn_lvl_pressed():
	emit_signal("next_level",level)
