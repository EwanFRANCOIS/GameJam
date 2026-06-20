extends Area2D

@onready var camera_DEESSE = $"../Camera2D"

var player_in_range : bool = false

func _ready():
	camera_DEESSE.enabled = false
	
	body_entered.connect(func(body):
		if (body.name == "MainPerso"):
			player_in_range = true
		)
	
	body_exited.connect(func(body):
		if (body.name == "MainPerso"):
			player_in_range = false
		)
	
	TextBox.text_queue_completed.connect(func():
		if (camera_DEESSE.enabled):
			camera_DEESSE.enabled = false
			get_node("/root/Scene/MainPerso/Camera2D").enabled = true
			get_node("/root/Scene/MainPerso/Camera2D").make_current())

func _process(_delta):
	if (player_in_range and Input.is_action_just_pressed("Interact")):
		declencher_dialogue()

func declencher_dialogue():
	if (TextBox.current_state == TextBox.STATE.READY):
		get_node("/root/Scene/MainPerso/Camera2D").enabled = false
		camera_DEESSE.enabled = true
		camera_DEESSE.make_current()
		TextBox.queue_text("Âme perdue...")
		TextBox.queue_text("Tu as entendu mes larmes ainsi que ma souffrance...")
		TextBox.queue_text("Je crains que tu sois la seule encore libre de ce monde maintenant corrompu par toutes ces abominations qui ont fait perdre à notre ville son eau d'autant...")
		TextBox.queue_text("Je t'en prie, âme perdue, je sais que cela peut te rendre confuse, mais j'ai besoin de toi pour des raisons bien précises...")
		TextBox.queue_text("Je n'ai pas réellement le temps de tout t'expliquer, mais tu dois me faire confiance malgré les erreurs que j'ai commises il y a bien fort longtemps...")
		TextBox.queue_text("Tu trouveras Charles pas très loin, il pourra te proposer ses services de marchandises.")
		TextBox.queue_text("Toute cette brume autour de ma belle fontaine me terrasse depuis bien longtemps. Aurais-tu la bonté de terrasser la créature plus haut et de soigner les arbres morts pour retirer cette fumée ?")
		TextBox.queue_text("Je te souhaite bonne chance et que la force de Xitilis soit avec toi.")
