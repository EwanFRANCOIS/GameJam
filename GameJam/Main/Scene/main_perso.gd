extends CharacterBody2D

@onready var AnimatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 400

var moveDir = ""

func _ready() -> void:
	pass
	#moveDir = "idle"
	#AnimatedSprite.play("idle")

func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.

func animPerso():
	if Input.is_action_pressed("left"):
		if AnimatedSprite.animation != "leftW":
			AnimatedSprite.play("leftW")
	elif Input.is_action_pressed("right"):
		if AnimatedSprite.animation != "rightW":
			AnimatedSprite.play("rightW")
	elif Input.is_action_pressed("down"):
		if AnimatedSprite.animation != "downW":
			AnimatedSprite.play("downW")
	elif Input.is_action_pressed("up"):
		if AnimatedSprite.animation != "upW":
			AnimatedSprite.play("upW")
	else:
		if AnimatedSprite.animation != "idle":
			AnimatedSprite.play("idle")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func _physics_process(delta: float) -> void:
	get_input()
	animPerso()
	move_and_slide()
