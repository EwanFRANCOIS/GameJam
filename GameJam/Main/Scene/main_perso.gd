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

var AllSkills : Array[String] = ["Watering can", "Heal"]
var inventorySKills : Array[String] = ["Watering can", "Heal"]
var inCooldownSkills : Array[String] = []

func useSkill(skillName : String):
	if inventorySKills.find(skillName) != -1:
		if inCooldownSkills.find(skillName) == -1:
			# We own the skill and it's not in cooldown
			# Add skill to cooldown
			inCooldownSkills.append(skillName)
			# Use skill (icon)
			var sprite = $SkillEfect/Sprite2D
			if skillName == "Watering can":
				sprite.texture = load("res://Main/Textures/wateringCan.png")
			await get_tree().create_timer(1.0).timeout # cooldown de 1 seconde
			sprite.texture = null
			# Use skill (code)
			var racineNode = owner
			
			if skillName == "Watering can":
				var natureLife = racineNode.get_node("NatureLife")
				for life : StaticBody2D in natureLife.get_children():
					var distance = life.get_node("CollisionShape2D").global_position.distance_to(global_position)
					if distance < 160:
						life.get_node("Sprite2D").texture = load("res://Main/Textures/Pixelated tree sprites/Pink tree.png")
						racineNode.get_node("Fogs/FogOverlay").lights.append(life)
			
			# Cooldown
			if skillName == "Watering can":
				var skillNode = racineNode.get_node("SkillUI/CanvasLayer/MarginContainer/Skill1")
				var cooldown : float = 5.0 # cooldown de 5 secondes
				skillNode.temps_cooldown_total = cooldown
				skillNode.lancer_cooldown()
				for i in range(cooldown):
					skillNode.get_node("Label").text = str(cooldown-i)
					await get_tree().create_timer(1.0).timeout
				skillNode.get_node("Label").text = ""
			
			# Remove skill from cooldown
			inCooldownSkills.remove_at(inCooldownSkills.find(skillName))

func checkSkills():
	# call_deferred execute la fonction en parallele
	if Input.is_action_pressed("skill1"):
		useSkill.call_deferred(AllSkills[0])
	elif Input.is_action_pressed("skill2"):
		useSkill.call_deferred(AllSkills[1])

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
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	# Dash
	if Input.is_action_pressed("dash") and isDashing != true and inCooldown_dash != true:
		if input_direction != Vector2.ZERO:
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
	if isDashing == true:
		velocity = input_direction * dashSpeed
	else:
		velocity = input_direction * speed

var lastColorIndexDashEffect = 0
func spawnDashEffect() -> void:
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
	ghost.modulate = colors[lastColorIndexDashEffect-1] # colors[randi() % colors.size()]
	
func dashEffect(delta) -> void:
	if isDashing:
		ghost_timer-=delta
		if ghost_timer <= 0:
			lastColorIndexDashEffect+=1
			if lastColorIndexDashEffect > 3:
				lastColorIndexDashEffect = 1
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
	# Skills
	checkSkills()
	# Movement
	move_and_slide()
