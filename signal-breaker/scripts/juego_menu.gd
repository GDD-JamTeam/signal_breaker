class_name JuegoMenu extends Control


@onready var canvas_layer: CanvasLayer = $Menus
@onready var menu_pausa: ColorRect = $Menus/Pausa
@onready var menu_muerte: ColorRect = $Menus/Muerte
@onready var menu_victoria: ColorRect = $Menus/Victoria


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


#region Funciones


func pausar_juego():
	menu_pausa.show()
	get_tree().paused = true


func reanudar_juego():
	get_tree().paused = false
	menu_pausa.hide()


func mostrar_muerte():
	# Espera un segundo antes de mostrar el menú
	await get_tree().create_timer(1.0).timeout
	menu_muerte.show()
	get_tree().paused = true


func mostrar_victoria():
	menu_victoria.show()
	get_tree().paused = true


#endregion


#region Botones


func _on_continuar_pressed() -> void:
	reanudar_juego()


func _on_reiniciar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().paused = false
	SceneManager.change_to_scene("start_menu")


#endregion
