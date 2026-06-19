extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BgmMenu.play_music_menu()
	WindSoundAmbiant.stop()

func _on_jouer_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/Scene/scene.tscn")
	BgmMenu.stop()
	WindSoundAmbiant.play()


func _on_classement_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/Scene/menu_classement.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/Scene/menu_options.tscn")


func _on_quitter_pressed() -> void:
	get_tree().quit()
