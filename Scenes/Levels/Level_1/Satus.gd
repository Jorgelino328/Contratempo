extends Level
@onready var new_song = load("res://Assets/Audio/Satus.ogg")
var playing = false

func _process(delta):
	super._process(delta)
	if(!playing):
		emit_signal("change_song",new_song)
		playing = true
