extends Area2D


signal victory()


## Gestiona la victoria del jugador
func _on_area_entered(area: Area2D) -> void:
	var target := area.get_parent()
	if target.is_in_group(&"player"): victory.emit()
