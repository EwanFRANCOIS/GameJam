extends Area2D

@onready var BOSS_MUSIC = $"../BOSSMUSIC"
@onready var camera_BOSS = $"../camera_Boss"
@onready var STATE_MACHINE = $"../FinitStateMachine"

var cinematique_joue : bool = false


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	body_entered.connect(func(body):
		if (body.name == "MainPerso" and not cinematique_joue):
			declencherDialogue()
			cinematique_joue = true
	)
	
	body_exited.connect(func(body):
		if (body.name == "MainPerso"):
			BOSS_MUSIC.stop()
	)
	
	TextBox.text_queue_completed.connect(func():
		if (camera_BOSS.enabled):
			camera_BOSS.enabled = false
			get_node("/root/Scene/MainPerso/Camera2D").enabled = true
			get_node("/root/Scene/MainPerso/Camera2D").make_current()
			get_tree().paused = false
			
			var boss = get_node_or_null("/root/Scene/Boss")
			if (not boss):
				boss = get_node_or_null("/root/Scene/boss")
			if (boss):
				boss.combat_commence = true
	)

func declencherDialogue():
	if (TextBox.current_state == TextBox.STATE.READY):
		BOSS_MUSIC.play()
		get_node("/root/Scene/MainPerso/Camera2D").enabled = false
		camera_BOSS.enabled = true
		camera_BOSS.make_current()
		get_tree().paused = true
		TextBox.queue_text("...")
		TextBox.queue_text("Une âme perdue...")
		TextBox.queue_text("Je t'ai entendu parler avec l'autre incapable...")
		TextBox.queue_text("Sache que je suis installé ici depuis bien longtemps.")
		TextBox.queue_text("Je ne laisserais en aucun cas ma place à une simple vermine comme toi !")
		
		get_node("..").fight_started = true
		
		var boss = get_node_or_null("../")
		if (boss and boss.has_node("$../HP_BAR")):
			boss.get_node("$../HP_BAR").visible = true
