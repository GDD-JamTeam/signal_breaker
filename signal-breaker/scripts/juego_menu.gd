extends Control


@onready var menu_pausa = $Menus/Pausa
@onready var menu_muerte = $Menus/Muerte
@onready var menu_victoria = $Menus/Victoria


func _ready():
	get_tree().paused = false
	menu_pausa.hide()
	menu_muerte.hide()
	menu_victoria.hide()


func _process(_delta):
	if not Input.is_action_just_pressed("quit"): return

	if not get_tree().paused:
		pausar_juego()
	else:
		reanudar_juego()


func pausar_juego():
	menu_pausa.show()
	get_tree().paused = true


func reanudar_juego():
	get_tree().paused = false
	menu_pausa.hide()


func mostrar_muerte():
	menu_muerte.show()
	get_tree().paused = true


func mostrar_victoria():
	menu_victoria.show()
	get_tree().paused = true


func _on_continuar_pressed() -> void:
	reanudar_juego()


func _on_reiniciar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().paused = false
	SceneManager.change_to_scene("start_menu")


func _on_enemigo_1_body_entered(body: Node2D) -> void:
	# Verificamos que quien chocó fue el Jugador
	if body.name == "JugadorMenu":
		mostrar_muerte()


func _on_enemigo_2_body_entered(body: Node2D) -> void:
	# Verificamos que quien chocó fue el Jugador
	if body.name == "JugadorMenu":
		mostrar_victoria()
