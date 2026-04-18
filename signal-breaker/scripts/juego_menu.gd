extends Node2D


@onready var menu_pausa = $Menus/Pausa
@onready var menu_muerte = $Menus/Muerte
@onready var menu_victoria = $Menus/Victoria

func _ready():

	get_tree().paused = false
	menu_pausa.hide()
	menu_muerte.hide()
	menu_victoria.hide()

func _process(_delta):
   
	if Input.is_action_just_pressed("ui_cancel"):
		if not get_tree().paused:
			pausar_juego()
		else:
			reanudar_juego()


func pausar_juego():
	get_tree().paused = true
	menu_pausa.show()

func reanudar_juego():
	get_tree().paused = false
	menu_pausa.hide()

func mostrar_muerte():
	get_tree().paused = true
	menu_muerte.show()

func mostrar_victoria():
	get_tree().paused = true
	menu_victoria.show()


func _on_continuar_pressed() -> void:
	reanudar_juego()

func _on_reiniciar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/menus/menu_inicio.tscn")





func _on_enemigo_1_body_entered(body: Node2D) -> void:
	# Verificamos que quien chocó fue el Jugador
	if body.name == "JugadorMenu":
		mostrar_muerte()


func _on_enemigo_2_body_entered(body: Node2D) -> void:
	# Verificamos que quien chocó fue el Jugador
	if body.name == "JugadorMenu":
		mostrar_victoria()
