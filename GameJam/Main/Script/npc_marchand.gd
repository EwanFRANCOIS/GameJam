extends Area2D

@onready var camera_MARCHAND = $"../Camera2D"

var player_in_range : bool = false

func _ready():
	camera_MARCHAND.enabled = false
	
	body_entered.connect(func(body):
		if (body.name == "MainPerso"):
			player_in_range = true
		)
	
	body_exited.connect(func(body):
		if (body.name == "MainPerso"):
			player_in_range = false
		)
	
	TextBox.text_queue_completed.connect(func():
		if (camera_MARCHAND.enabled):
			camera_MARCHAND.enabled = false
			$"../../MainPerso/Camera2D".enabled = true
			$"../../MainPerso/Camera2D".make_current())

func _process(_delta):
	if (player_in_range and Input.is_action_just_pressed("Interact")):
		declencher_dialogue()


func declencher_dialogue():
	if (TextBox.current_state == TextBox.STATE.READY):
		$"../../MainPerso/Camera2D".enabled = false
		camera_MARCHAND.make_current()
		camera_MARCHAND.enabled = true
		TextBox.queue_text("Si c'est pour mon argent, partez ! J'ai déjà tout perdu !")
		TextBox.queue_text("...")
		TextBox.queue_text("...")
		TextBox.queue_text("...")
		TextBox.queue_text("Oh... Vous n'êtes pas une abonimation...")
		TextBox.queue_text("...")
		TextBox.queue_text("Je me présente, je suis Charles ! La déesse vous a probablement parlé de moi hehe.")
		TextBox.queue_text("Il faut bien croire que je suis le dernier marchand qui arrive à vivre ici (et encore si on parle pas de toutes les créatures dans le coin)")
		TextBox.queue_text("Personne ne connait son nom, la seule chose que je sais sur elle, c'est qu'elle a perdu ses pouvoirs d'autant et qu'elle recherche une âme 'pure'.")
		TextBox.queue_text("Qui sait ce qu'elle veut réellement.")
		TextBox.queue_text("Bref, comme tu peux le constater, je suis marchand et...")
		TextBox.queue_text("Je")
		TextBox.queue_text("n'ai")
		TextBox.queue_text("aucun")
		TextBox.queue_text("sous !")
		TextBox.queue_text("Mais j'ai vraiment beaucoup d'artefacts ou d'autres objets pour toi, bien évidemment, ils ne seront pas gratuits, mais vu tous les propos que la déesse a pu dire sur toi, je me dois de t'offrir cet arrosoir !")
		TextBox.queue_text("Et si tu veux bien, avant d'accéder à mes articles, j'aimerais bien que tu te débarrasses de la chose en haut pour moi, je ne sais pas me battre et j'ai beaucoup trop peur de ce truc.")
		TextBox.queue_text("Il est coriace mais je sais que tu vas y arriver, et aussi profite-en pour nettoyer les arbres aux alentours, ça nous enlèvera cette brume horrible !")
