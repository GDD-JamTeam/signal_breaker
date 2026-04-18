extends base_entity

# variables
var on_range: bool = false
var is_alive: bool = true
func _on_attack_range_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		var body = area.get_parent()
		if body is CharacterBody2D:
			on_range = true


func _on_attack_range_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		var body = area.get_parent()
		if body is CharacterBody2D:
			on_range = false
