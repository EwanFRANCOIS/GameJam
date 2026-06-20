extends CanvasLayer

const CHAR_READ_RATE = 0.05

signal text_queue_completed

@onready var textBoxContainer = $MarginContainer
@onready var startSymbol = $MarginContainer/MarginContainer/HBoxContainer/Start
@onready var labelText = $MarginContainer/MarginContainer/HBoxContainer/Text
@onready var textEnd = $MarginContainer/MarginContainer/HBoxContainer/End
@onready var AudioDialogue = $AudioDialogue

var tween: Tween
var text_queue = []

enum STATE {
	READY,
	READING,
	FINISHED
}

var current_state = STATE.READY

func _ready():
	AudioDialogue.process_mode = Node.PROCESS_MODE_ALWAYS
	hideTextBox()

func _process(delta):
	match current_state:
		STATE.READY:
			if (!text_queue.is_empty()):
				displayText()
		STATE.READING:
			if (Input.is_action_just_pressed("ui_accept")):
				labelText.visible_ratio = 1.0
				tween.kill()
				_on_tween_completed()
				change_state(STATE.FINISHED)
		STATE.FINISHED:
			if (Input.is_action_just_pressed("ui_accept")):
				var last_text = text_queue.is_empty()
				change_state(STATE.READY)
				hideTextBox()
				
				if (last_text):
					text_queue_completed.emit()

func queue_text(nextText):
	text_queue.push_back(nextText)

func hideTextBox():
	startSymbol.text = ""
	textEnd.text = ""
	labelText.text = ""
	textBoxContainer.hide()

func showTextBox():
	startSymbol.text = "*"
	textBoxContainer.show()

func displayText():
	var nextText = text_queue.pop_front()
	labelText.text = nextText
	change_state(STATE.READING)
	showTextBox()
	
	tween = create_tween()
	tween.tween_property(labelText, "visible_ratio", 1.0, len(nextText) * CHAR_READ_RATE).from(0.0)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	for i in range(len(nextText)):
		var temp_declenchement = i * CHAR_READ_RATE
		if (nextText[i] != " "):
			tween.parallel().tween_callback(jouer_son).set_delay(temp_declenchement)
	
	tween.finished.connect(_on_tween_completed)

func jouer_son():
	if (AudioDialogue):
		AudioDialogue.play()

func _on_tween_completed():
	textEnd.text = "v"
	change_state(STATE.FINISHED)


func change_state(next_state):
	current_state = next_state
	match current_state:
		STATE.READY:
			print("CHANGE TO STATE.READING")
		STATE.READING:
			print("CHANGE TO STATE.FINISHED")
		STATE.FINISHED:
			print("CHANGE TO STATE.READY")
