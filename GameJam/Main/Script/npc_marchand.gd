extends Area2D

@onready var camera_MARCHAND = $"../Camera2D"
@onready var AFFICHAGE_TOUCHE_F = $"../PIVOT_UI/AFFICHAGE_TOUCHE_F"
@onready var PIVOT = $"../PIVOT_UI"

var player_in_range : bool = false

func _ready():
	camera_MARCHAND.enabled = false
	
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
		if (camera_MARCHAND.enabled):
			camera_MARCHAND.enabled = false
			get_node("/root/Scene/MainPerso/Camera2D").enabled = true
			get_node("/root/Scene/MainPerso").unlockedSKills = true
			get_node("/root/Scene/MainPerso/Camera2D").make_current()
			TextBox.AFFICHAGE_NPC_MARCHAND.visible = false)

func _process(_delta):
	if (player_in_range and Input.is_action_just_pressed("Interact")):
		declencher_dialogue()


func declencher_dialogue():
	if (TextBox.current_state == TextBox.STATE.READY):
		TextBox.AFFICHAGE_NPC_MARCHAND.visible = true
		get_node("/root/Scene/MainPerso/Camera2D").enabled = false
		camera_MARCHAND.enabled = true
		camera_MARCHAND.make_current()
		
		var boss = get_node_or_null("/root/Scene/Boss")
		if (not boss):
			boss = get_node_or_null("/root/Scene/boss")
		
		if (boss == null):
			dialogue_boss_mort()
		else:
			dialogue_base()

func dialogue_base():
		TextBox.queue_text("Si c'est pour mon argent, partez ! J'ai déjà tout perdu !")
		TextBox.queue_text("...")
		TextBox.queue_text("...")
		TextBox.queue_text("...")
		TextBox.queue_text("Oh... Vous n'êtes pas une abomination...")
		TextBox.queue_text("...")
		TextBox.queue_text("Je me présente, je suis Isabelle ! La déesse vous a probablement parlé de moi hehe.")
		TextBox.queue_text("Il faut bien croire que je suis le dernier marchand qui arrive à vivre ici (et encore si on parle pas de toutes les créatures dans le coin)")
		TextBox.queue_text("Personne ne connait son nom, la seule chose que je sais sur elle, c'est qu'elle a perdu ses pouvoirs d'autant et qu'elle recherche une âme 'pure'.")
		TextBox.queue_text("Qui sait ce qu'elle veut réellement.")
		TextBox.queue_text("Bref, comme tu peux le constater, je suis marchand et...")
		TextBox.queue_text("Je")
		TextBox.queue_text("n'ai")
		TextBox.queue_text("aucun")
		TextBox.queue_text("sous !")
		TextBox.queue_text("Mais j'ai beaucoup d'artefacts ou d'autres objets pour toi. Évidemment, ils ne seront pas gratuits, mais vu tous les propos que la déesse a pu dire sur toi, je me dois de t'offrir cet arrosoir !")
		TextBox.queue_text("Et si tu veux bien, avant d'accéder à mes articles, j'aimerais bien que tu te débarrasses de la chose en haut pour moi, je ne sais pas me battre et j'ai beaucoup trop peur de ce truc.")
		TextBox.queue_text("Il est coriace mais je sais que tu vas y arriver, et aussi profite-en pour nettoyer les arbres aux alentours, ça nous enlèvera cette brume horrible !")
		TextBox.queue_text("[VOUS AVEZ OBTENU: ARROSOIR]")

func dialogue_boss_mort():
	TextBox.queue_text("Oh, te revoilà !")
	TextBox.queue_text("J'ai vu au loin que t'avais tué ce boss et franchement bravo à toi.")
	TextBox.queue_text("Pour te remercier, je te laisse garder l'arrosoir ( ;) ), il te sera peut-être utile si d'autres abominations comme lui arrivent !")
	TextBox.queue_text("Et Xitilis sait à quel point ces choses me foutent la trouille ! Je n'ai absolument pas envie de me battre contre ces trucs !")
	TextBox.queue_text("Bref, comme promis, tu m'as aidé, je te donne donc l'accès à mon magasin, je vends deux trois choses qui pourraient t'intéresser.")
	TextBox.queue_text("Peut-être qu'au final, la déesse ne s'est pas trompée, je l'espère...")
	TextBox.queue_text("Les précédents ont mal fini après tout par sa faute...")
	TextBox.queue_text("Oops j'en dis un peu trop haha...")
	TextBox.queue_text("...")
	TextBox.queue_text("Bref ! Si tu cherches bel et bien à nous sauver, il y a en bas des créatures, un peu moins féroces que celle que tu viens d'affronter.")
	TextBox.queue_text("Mais après ce combat, je pense que tu es capable de les tuer, pas vrai ?")
	TextBox.queue_text("Tu auras donc accès à mon magasin après les avoir exterminées et encore merci !")
