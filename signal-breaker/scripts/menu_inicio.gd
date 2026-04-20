extends Control


func _on_play_pressed() -> void:
	MusicManager.switch_music_playing(false)
	SceneManager.change_to_scene("battle")


func _on_quit_pressed() -> void:
	get_tree().quit()
