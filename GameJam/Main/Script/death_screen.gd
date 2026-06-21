extends CanvasLayer

func _on_button_retour_menu_pressed() -> void:
	get_tree().paused = false
	BgmMenu.play()
	get_tree().change_scene_to_file("res://Main/Scene/main_menu.tscn")
