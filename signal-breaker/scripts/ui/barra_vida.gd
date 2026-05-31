class_name BarraVida extends Control


@export var health_bar: ProgressBar
@export var damage_bar: ProgressBar


var player: Player


func _ready() -> void:
	player = get_tree().get_first_node_in_group(&"player")

	if player == null:
		print("[BarraVida] No se encontro al jugador.")
		return

	# Inicializar valores
	health_bar.max_value = player.health
	damage_bar.max_value = player.health

	health_bar.value = player.health
	damage_bar.value = player.health

	# Conectar señal
	player.get_hurt_signal.connect(_on_player_hurt)


## Actualiza las barras de vida cuando el jugador recibe daño
func _on_player_hurt() -> void:
	# 🔥 Barra principal baja instantáneo
	health_bar.value = player.health

	# 🔥 Barra secundaria baja con delay + tween
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.1) # Pequeño delay para efecto visual
	tween.tween_property(damage_bar, "value", player.health, 1.0)
