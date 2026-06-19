extends Node2D

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
		bulles[i].visible = false


func prendre_degats():
	# sécurité : pas de dégâts si mort ou invincible
	if pv <= 0 or invincible:
		return

	pv -= 1

	# mise à jour visuelle
	eaux[pv].visible = false
	bulles[pv].visible = true

	# invincibilité (3 secondes)
	invincible = true
	await get_tree().create_timer(3.0).timeout
	invincible = false
