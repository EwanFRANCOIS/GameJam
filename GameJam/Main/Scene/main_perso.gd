extends CharacterBody2D

@onready var AnimatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 200

var lastMoveDir = ""

func _ready() -> void:
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.

func animPerso():
	if Input.is_action_pressed("left"):
		if AnimatedSprite.animation != "leftW":
			AnimatedSprite.play("leftW")
			lastMoveDir = "left"
	elif Input.is_action_pressed("right"):
		if AnimatedSprite.animation != "rightW":
			AnimatedSprite.play("rightW")
			lastMoveDir = "right"
	elif Input.is_action_pressed("down"):
		if AnimatedSprite.animation != "downW":
			AnimatedSprite.play("downW")
			lastMoveDir = "down"
	elif Input.is_action_pressed("up"):
		if AnimatedSprite.animation != "upW":
			AnimatedSprite.play("upW")
			lastMoveDir = "up"
	else:
		if lastMoveDir == "up":
			if AnimatedSprite.animation != "idleU":
				AnimatedSprite.play("idleU")
		elif lastMoveDir == "left":
			if AnimatedSprite.animation != "idleL":
				AnimatedSprite.play("idleL")
		elif lastMoveDir == "right":
			if AnimatedSprite.animation != "idleR":
				AnimatedSprite.play("idleR")
		else:
			if AnimatedSprite.animation != "idleD":
				AnimatedSprite.play("idleD")

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func _physics_process(delta: float) -> void:
	get_input()
	animPerso()
	move_and_slide()
