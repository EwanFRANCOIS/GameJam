extends Area2D

var player_in_range : bool = false

func _ready():
	body_entered.connect(func(body):
		if (body.name == "MainPerso"):
			player_in_range = true
		)
	
	body_exited.connect(func(body):
		if (body.name == "MainPerso"):
			player_in_range = false
		)

func _process(_delta):
	if (player_in_range and Input.is_action_just_pressed("Interact")):
		declencher_dialogue()

func declencher_dialogue():
	if (TextBox.current_state == TextBox.STATE.READY):
		TextBox.queue_text("Kris ! GET THE BANANA !!!")
		TextBox.queue_text("Potasium")
		TextBox.queue_text("ina ina ina ina ina")
