extends ProgressBar

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	if player == null:
		print("[BarraVida] No se encontro al jugador.")
		return
	
	max_value = player.health
	value = player.get_health()
	
	player.get_hurt_signal.connect(_on_player_hurt)

func _on_player_hurt():
	value = player.get_health()
