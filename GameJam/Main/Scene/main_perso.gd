extends CharacterBody2D

@onready var AnimatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ghost_effect = $DashEffect

@export var speed = 300

@export var dashSpeed = 900
@export var dashLifeTime = .2
var isDashing = false
var dashTimer = 0
var ghost_timer = 0.0
var ghost_interval = 0.05

var inCooldown_dash = false
var cooldownDash = .7
var cooldownDash_timer = 0.0

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

func get_input(delta: float):
	# Dash
	if Input.is_action_pressed("dash") and isDashing != true and inCooldown_dash != true:
		# Start dashing
		isDashing = true
		dashTimer = delta
		ghost_timer = ghost_interval
		
		inCooldown_dash = true
		cooldownDash_timer = 0
	elif isDashing == true:
		# Stop dashing if timer exceed dash lifetime
		dashTimer += delta
		if dashTimer > dashLifeTime:
			isDashing = false
	
	# Velocity
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if isDashing == true:
		velocity = input_direction * dashSpeed
	else:
		velocity = input_direction * speed

func spawnDashEffect() -> void:
	print(get_children())
	var ghost = get_node("DashEffect").duplicate()
	get_parent().add_child(ghost)
	
	ghost.is_original = false
	ghost.global_position = global_position
	ghost.scale = scale

	var ghost_sprite = ghost.get_node("AnimatedSprite2D")
	var player_sprite = $AnimatedSprite2D

	ghost_sprite.global_position = $AnimatedSprite2D.global_position
	ghost_sprite.scale = $AnimatedSprite2D.scale

	# Copier les frames
	ghost_sprite.sprite_frames = player_sprite.sprite_frames
	# Copier l’animation en cours
	ghost_sprite.animation = player_sprite.animation
	# Copier la frame actuelle
	ghost_sprite.frame = player_sprite.frame
	# Stopper l’animation de l'effet
	ghost_sprite.stop()

	# Couleur
	var colors = [
		Color(1, 0, 0, 0.7),
		Color(0, 1, 1, 0.7),
		Color(1, 1, 0, 0.7)
	]
	ghost.modulate = colors[randi() % colors.size()]
	
func dashEffect(delta) -> void:
	if isDashing:
		ghost_timer-=delta
		if ghost_timer <= 0:
			spawnDashEffect()
			ghost_timer = ghost_interval
	
func _physics_process(delta: float) -> void:
	# Dash cooldown
	if inCooldown_dash:
		cooldownDash_timer+=delta
		if cooldownDash_timer > cooldownDash:
			inCooldown_dash = false
	
	# Apply Velocity
	get_input(delta)
	# Animation
	animPerso()
	# Dash Effect
	dashEffect(delta)
	# Movement
	move_and_slide()
