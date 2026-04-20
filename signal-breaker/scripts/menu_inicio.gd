extends Control


func _on_play_pressed() -> void:
	SceneManager.change_to_scene("battle")


func _on_quit_pressed() -> void:
	get_tree().quit()
