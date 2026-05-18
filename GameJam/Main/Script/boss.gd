extends CharacterBody2D

@export var bullet_scene: PackedScene

@export_category("Configuration du Tir")
@export var bullets_per_wave: int = 8   # Nombre de balles envoyées en même temps
@export var fire_rate: float = 0.15     # Temps en secondes entre chaque salve
@export var rotation_speed: float = 0.2  # Vitesse de rotation de la spirale

@onready var shoot_timer: Timer = $ShootTimer

# tourne en continue pour donner l'effet spirale
var current_rotation_offset: float = 0.0

func _ready() -> void:
	# Configuration du Timer
	shoot_timer.wait_time = fire_rate
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:
	if not bullet_scene:
		print("ERROR : oublie de glisser la scene de 'bullet' dans l'inspecteur du boss")
		return 
	
	# TAU = 2 * PI (soit 360 degrés en radians). 
	# On divise 360° par le nombre de balles pour avoir un angle régulier.
	var angle_step: float = TAU / bullets_per_wave
	
	for i in range(bullets_per_wave):
		# On calcule l'angle de cette balle spécifique + l'offset global
		var bullet_angle: float = (i * angle_step) + current_rotation_offset
		
		# On instancie (duplique) la balle
		var bullet = bullet_scene.instantiate()
		
		# On place la balle sur le boss
		bullet.global_position = global_position
		
		# On lui donne sa direction (la fonction qu'on a codée avant !)
		bullet.set_direction(bullet_angle)
		
		# IMPORTANT : On ajoute la balle à la scène principale du jeu.
		# Si on l'ajoutait en enfant du boss, les balles bougeraient en même temps que le boss.
		get_tree().current_scene.add_child(bullet)
	
	# On fait évoluer l'offset pour la prochaine salve (effet de rotation)
	current_rotation_offset += rotation_speed
