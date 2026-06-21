extends Node2D

@onready var DEATH_SCREEN = $"../../DEATH_SCREEN"

var pv_max = 5
var pv = pv_max
var invincible = false

@onready var eaux = [
	$eau1,
	$eau2,
	$eau3,
	$eau4,
	$eau5
]

@onready var bulles = [
	$bulle1,
	$bulle2,
	$bulle3,
	$bulle4,
	$bulle5
]

func _ready():
	# état propre au lancement
	for i in range(eaux.size()):
		eaux[i].visible = true
		bulles[i].visible = true


func prendre_degats():
	# sécurité : pas de dégâts si mort ou invincible
	if pv <= 0 or invincible:
		return

	pv -= 1
	
	if (pv <= 0):
		death()
	
	# mise à jour visuelle
	eaux[pv].visible = false
	bulles[pv].visible = false

	# invincibilité (2 secondes)
	invincible = true
	await get_tree().create_timer(2.0).timeout
	invincible = false

func death():
	get_tree().paused = true
	BgmMenu.stop()
	WindSoundAmbiant.stop()
	DEATH_SCREEN.visible = true
