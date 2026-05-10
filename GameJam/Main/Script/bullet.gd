extends Node2D

const speed = 200

func _process(delta):
	position += transform.x * speed * delta

func _on_kill_bullet_timer_timeout() -> void:
	queue_free()
