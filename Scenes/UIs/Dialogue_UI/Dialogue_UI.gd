extends Control
@export var dialoguePath = "res://Assets/Dialogue/Teste.json"
@export var textSpeed := 0.05
var dialogue
var phraseNum = 0 
var finished = false
var cat = false

signal caaat(run)
signal cat_over()
signal dialogue_stop()

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$Timer.wait_time = textSpeed
	dialogue = getDialogue()
	assert(dialogue, "Dialogue not found")
	nextPhrase()
		
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$VBoxContainer/Panel/Text.visible_characters = len($VBoxContainer/Panel/Text.text)

func getDialogue():
	var f = FileAccess.open(dialoguePath,FileAccess.READ)
	assert(f.file_exists(dialoguePath), "File path does not exist")
	var json_object = JSON.new()
	var parse_err = json_object.parse(f.get_as_text())
	var output = json_object.get_data()
	if typeof(output) == TYPE_ARRAY :
		return output
	else:
		return parse_err
	
func nextPhrase():
	if phraseNum >= len(dialogue):
		emit_signal("dialogue_stop")
		queue_free()
		return
		
	finished = false
	
	$VBoxContainer/Panel/Name.bbcode_text = dialogue[phraseNum]["Name"]
	
	$VBoxContainer/Panel/Text.bbcode_text = dialogue[phraseNum]["Text"]
	if(dialogue[phraseNum]["Name"] == "Criatura Estranha"):
		if(!cat):
			cat = true
			if (dialogue[phraseNum]["Text"]  == "*Corre*"):
				emit_signal("caaat", true)
			else:
				emit_signal("caaat", false)
	else:
		if(cat):
			cat = false
			emit_signal("cat_over")
			
	$VBoxContainer/Panel/Text.visible_characters = 0

	var f = FileAccess.open(dialoguePath,FileAccess.READ)
	var img = "res://Assets/Dialogue/" + dialogue[phraseNum]["Name"] + dialogue[phraseNum]["Emotion"] + ".png" 
	if f.file_exists(img):
		$VBoxContainer/Panel/Portrait.texture =  load(img)
	else:
		$VBoxContainer/Panel/Portrait.texture =  null
		
	while $VBoxContainer/Panel/Text.visible_characters < len($VBoxContainer/Panel/Text.text):
		$VBoxContainer/Panel/Text.visible_characters += 1 
		if(randi_range(0,100)*textSpeed > 1):
			$dialogueTick.play()
		$Timer.start()
		await $Timer.timeout
	
	finished = true
	phraseNum += 1
	return 
	
