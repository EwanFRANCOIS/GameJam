extends Area2D

@onready var camera_DEESSE = $"../Camera2D"
@onready var AFFICHAGE_TOUCHE_F = $"../PIVOT_UI2/AFFICHAGE_TOUCHE_F"
@onready var PIVOT = $"../PIVOT_UI2"

@onready var musicSad = get_node("../deesseSad")
@onready var musicHappy = get_node("../deesseHappy")

var player_in_range : bool = false

func _ready():
	camera_DEESSE.enabled = false
	
	if owner and owner.scale.x < 0:
		if PIVOT:
			PIVOT.scale.x = -1
	
	body_entered.connect(func(body):
		if (body.name == "MainPerso"):
			player_in_range = true
			AFFICHAGE_TOUCHE_F.visible = true
		)
	
	body_exited.connect(func(body):
		if (body.name == "MainPerso"):
			player_in_range = false
			AFFICHAGE_TOUCHE_F.visible = false
		)
	
	TextBox.text_queue_completed.connect(func():
		if (camera_DEESSE.enabled):
			camera_DEESSE.enabled = false
			
			musicSad.stop()
			musicHappy.stop()
			
			get_node("/root/Scene/MainPerso/Camera2D").enabled = true
			get_node("/root/Scene/Map/Fountain/NPC_GODDESS").hide()
			get_node("/root/Scene/MainPerso/Camera2D").make_current())

func _process(_delta):
	if (player_in_range and Input.is_action_just_pressed("Interact")):
		declencher_dialogue()

func declencher_dialogue():
	if (TextBox.current_state == TextBox.STATE.READY):
		get_node("/root/Scene/MainPerso/Camera2D").enabled = false
		get_node("/root/Scene/Map/Fountain/NPC_GODDESS").show()
		camera_DEESSE.enabled = true
		camera_DEESSE.make_current()
		
		var boss = get_node_or_null("/root/Scene/Boss")
		if (not boss):
			boss = get_node_or_null("/root/Scene/boss")
		
		if (boss == null):
			musicHappy.play()
			dialogue_boss_mort()
		else:
			musicSad.play()
			TextBox.queue_text("Âme perdue...")
			TextBox.queue_text("Tu as entendu mes larmes ainsi que ma souffrance...")
			TextBox.queue_text("Je crains que tu sois la seule encore libre de ce monde maintenant corrompu par toutes ces abominations qui ont fait perdre à notre ville son eau d'autant...")
			TextBox.queue_text("Je t'en prie, âme perdue, je sais que cela peut te rendre confuse, mais j'ai besoin de toi pour des raisons bien précises...")
			TextBox.queue_text("Je n'ai pas réellement le temps de tout t'expliquer, mais tu dois me faire confiance malgré les erreurs que j'ai commises il y a bien fort longtemps...")
			TextBox.queue_text("Tu trouveras Isabelle pas très loin, elle pourra te proposer ses services de marchandises.")
			TextBox.queue_text("Toute cette brume autour de ma belle fontaine me terrasse depuis bien longtemps. Aurais-tu la bonté de terrasser la créature plus haut et de soigner les arbres morts pour retirer cette fumée ?")
			TextBox.queue_text("Je te souhaite bonne chance et que la force de Xitilis soit avec toi.")

func dialogue_boss_mort():
	TextBox.queue_text("Âme perdue, je ne pourrais jamais suffisamment te remercier d'avoir détourner le brouillard de ma fontaine et d'avoir terrasser la créature qui me faisait face.")
	TextBox.queue_text("Maintenant qu'elle n'est plus là, les autres abominations devraient se calmer.")
	TextBox.queue_text("Si tu n'a pas encore parlée à Isabelle, je te conseil d'aller lui parler, elle a vu à qu'elle point tu avait détruit cette créature.")
	TextBox.queue_text("Je te remercie encore !")
