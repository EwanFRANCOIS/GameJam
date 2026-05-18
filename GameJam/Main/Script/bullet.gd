extends Area2D

@export var speed : float = 300.0
var velocity : Vector2 = Vector2.ZERO

func _ready() -> void:
	# Connection du signal pour detecter si on touche le jouer ou la fin de l'ecran
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# La balle avance en ligne droite selon sa vitesse
	position += velocity * speed * delta

func set_direction(angle: float) -> void:
	velocity = Vector2.RIGHT.rotated(angle)
	rotation = angle

func _on_body_entered(body : Node2D) -> void:
	if body.is_in_group("MainPerso"):
		queue_free()

func _on_screen_exited() -> void:
	queue_free()
