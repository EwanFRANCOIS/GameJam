extends CharacterBody2D

@export var enemyId : int = 0
@export var enemyName : String = "none"
@export var activated : bool = false

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	move_and_slide()
	
	# Pour enlever le bug de pot de colle
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is CharacterBody2D:
			global_position += col.get_normal() * 1
