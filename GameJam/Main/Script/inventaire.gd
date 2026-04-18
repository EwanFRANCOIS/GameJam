extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _input(event : InputEvent) -> void:
	if (Input.is_action_just_pressed("Inventaire")):
		visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
