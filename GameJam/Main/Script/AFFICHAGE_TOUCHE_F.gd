extends Area2D

@onready var AFFICHAGE_TOUCHE_F = $"../PIVOT_UI/AFFICHAGE_TOUCHE_F"
@onready var PIVOT = $"../PIVOT_UI"

func _ready():
	if owner and owner.scale.x < 0:
		if PIVOT:
			PIVOT.scale.x = -1
	
	body_entered.connect(func(body):
		if (body.name == "MainPerso"):
			AFFICHAGE_TOUCHE_F.visible = true
		)
	
	body_exited.connect(func(body):
		if (body.name == "MainPerso"):
			AFFICHAGE_TOUCHE_F.visible = false
		)
