extends Node2D

var delta: float = 10.0

var enemiesId : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BgmMenu.stop()

func generateMonster(enemyName : String) -> void:
	############## Create new monster
	var newMonster = $MonsterTemplate.duplicate()
	# Assign id
	newMonster.enemyId = enemiesId
	enemiesId = enemiesId+1
	# Assign name
	newMonster.enemyName = enemyName
	############## Add new monster
	$Enemies.add_child(newMonster)
	############## Activate new monster
	newMonster.activated = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
