extends Node2D

@export var is_original = false
@export var lifetime = 0.3
var timer = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_original:
		timer+=delta
		modulate.a = 1.0 - (timer/lifetime)
	
		if timer >= lifetime:
			queue_free()
