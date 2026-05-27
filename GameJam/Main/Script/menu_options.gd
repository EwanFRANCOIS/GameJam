extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retour_arriere_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/Scene/main_menu.tscn")


func _on_langue_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/Scene/menu_langue.tscn")


func _on_audio_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/Scene/menu_audio.tscn")
	

func _on_controles_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/Scene/menu_controles.tscn")
