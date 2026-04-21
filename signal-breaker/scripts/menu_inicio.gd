extends Control


@export var loop_anim: AnimatedTexture


@onready var background: TextureRect = $Background
@onready var buttons: HBoxContainer = $Buttons


func _ready() -> void:
	MusicManager.play_music("battle")

	# Desactivamos los botones
	buttons.visible = false

	# Esperamos un segundo y ponemos la animación y los botones
	await get_tree().create_timer(2.0).timeout
	background.texture = loop_anim
	buttons.visible = true


func _on_play_pressed() -> void:
	SceneManager.change_to_scene("battle")


func _on_options_pressed() -> void:
	SceneManager.change_to_scene("options")


func _on_quit_pressed() -> void:
	get_tree().quit()
