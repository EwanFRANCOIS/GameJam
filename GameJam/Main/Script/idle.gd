extends State

@onready var collision = %CollisionShape2D

var player_entered : bool = false :
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)

func _on_player_entered(body: Node2D) -> void:
	player_entered = true

func transition():
	if (TextBox.current_state != TextBox.STATE.READY):
		return
	
	if player_entered:
		get_parent().change_state("5leaf")
