class_name World extends Node2D


@export var player: Player
@export var menu: JuegoMenu


func _ready() -> void:
	# Pone la música de baralla
	MusicManager.play_music("battle")

	# Conecta la muerte del jugador con la del menu
	player.die_signal.connect(menu.mostrar_muerte)
