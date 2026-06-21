extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var boss = get_node_or_null("/root/Scene/Boss")
	if boss == null:
		$Sprite2D.texture = load("res://Main/Textures/placeVivante.png")
	else:
		$Sprite2D.texture = load("res://Main/Textures/placeDetruite.png")
