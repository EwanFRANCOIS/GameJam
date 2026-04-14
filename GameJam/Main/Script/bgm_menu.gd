extends AudioStreamPlayer2D

const main_musique = preload("res://Main/Audio/BGM_Theme.mp3")

func _music_menu(music : AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_music_menu():
	_music_menu(main_musique)
