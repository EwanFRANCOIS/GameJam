extends CharacterBody2D

@export var enemyId : int = 0
@export var enemyName : String = "none"
@export var activated : bool = false

const SPEED = 300.0

@export var rangeMovement : float = 200
@export var waitTime : float = 3.0

# _ready only runs once when the game start
var originalPosition : Vector2
var currPosition : Vector2
var blockVisual = ColorRect.new()
func _ready() -> void:
	originalPosition = global_position
	currPosition = originalPosition
	get_parent().add_child.call_deferred(blockVisual)
	
# display target position
func showTargetPos():
	blockVisual.size = Vector2(32, 32)
	blockVisual.color = Color.RED
	blockVisual.position = currPosition

# handle random movement around the original position
var currWaitTime : float = 0.0
func idleMovement(delta : float):
	if currWaitTime == 0:
		# Random movement
		var rand_x = randf_range(-rangeMovement, rangeMovement)
		var rand_y = randf_range(-rangeMovement, rangeMovement)
		currPosition = originalPosition+Vector2(rand_x, rand_y)
		
		showTargetPos()
		
		currWaitTime+=delta
	else:
		# Wait
		if currWaitTime < waitTime:
			currWaitTime+=delta
		else:
			currWaitTime = 0

func _physics_process(delta: float) -> void:
	# Random movement around spawn
	idleMovement(delta)
	# Move toward the current position
	velocity = currPosition-global_position
	#velocity = Vector2.ZERO
	move_and_slide()
	
	# Pour enlever le bug de pot de colle
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is CharacterBody2D:
			global_position += col.get_normal() * 1
