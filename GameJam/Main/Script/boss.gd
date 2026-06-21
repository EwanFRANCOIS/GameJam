extends CharacterBody2D

@onready var BOSS_HP_BAR = $HP_BAR
@export var MAX_HP : int = 100
var current_hp : int
var combat_commence : bool = false
var theta: float = 0.0
@export_range(0, 2 * PI) var alpha: float = 0.0

@export var bullet_node: PackedScene

func _ready():
	current_hp = MAX_HP
	
	if (BOSS_HP_BAR):
		BOSS_HP_BAR.max_value = MAX_HP
		BOSS_HP_BAR.value = MAX_HP

func recevoir_Dmg(montant : int):
	if (not combat_commence):
		return
	
	current_hp -= montant
	
	if (BOSS_HP_BAR):
		BOSS_HP_BAR.value = current_hp
	
	if (current_hp <= 0):
		mourir()

func mourir():
	if (has_node("BOSSMUSIC")):
		$BOSSMUSIC.stop()
		WindSoundAmbiant.play()
	queue_free()
	

func get_vector(angle):
	theta = angle + alpha
	return Vector2(cos(theta), sin(theta))

func shoot(angle):
	var bullet = bullet_node.instantiate()
	
	bullet.position = global_position
	bullet.direction = get_vector(angle)
	
	get_tree().current_scene.call_deferred("add_child", bullet)

func _on_speed_timeout() -> void:
	shoot(theta)
