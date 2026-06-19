extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var textBoxContainer = $MarginContainer
@onready var startSymbol = $MarginContainer/MarginContainer/HBoxContainer/Start
@onready var labelText = $MarginContainer/MarginContainer/HBoxContainer/Text
@onready var textEnd = $MarginContainer/MarginContainer/HBoxContainer/End

var tween: Tween
var text_queue = []

enum STATE {
	READY,
	READING,
	FINISHED
}

var current_state = STATE.READY

func _ready():
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
				change_state(STATE.READY)
				hideTextBox()

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
	tween.finished.connect(_on_tween_completed)


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
