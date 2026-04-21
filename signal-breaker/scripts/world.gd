class_name World extends Node2D


@export var player: Player
@export var menu: JuegoMenu
@export var victory_area: Area2D


func _ready() -> void:
	# Pone la música de baralla
	MusicManager.play_music("battle")

	# Conecta la muerte del jugador con la del menu
	player.die_signal.connect(menu.mostrar_muerte)

	# Conecta la victoria del jugador con la del menu
	victory_area.victory.connect(make_victory)


func make_victory() -> void:
	menu.mostrar_victoria()
