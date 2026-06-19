extends CanvasLayer

@onready var textBoxContainer = $MarginContainer
@onready var startSymbol = $MarginContainer/MarginContainer/HBoxContainer/Start
@onready var labelText = $MarginContainer/MarginContainer/HBoxContainer/Text
@onready var textEnd = $MarginContainer/MarginContainer/HBoxContainer/End

func _ready():
	hideTextBox()
	add_text("Kris get the banana !")

func hideTextBox():
	startSymbol.text = ""
	textEnd.text = ""
	labelText.text = ""
	textBoxContainer.hide()

func showTextBox():
	startSymbol.text = "*"
	textBoxContainer.show()

func add_text(nextText):
	labelText = nextText
	showTextBox()
