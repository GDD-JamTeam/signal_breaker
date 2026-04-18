extends base_entity

@export var attack_1: Area2D
@export var attack_2: Area2D
@export var attack_3: Area2D


func _ready() -> void:
	disable_damage_box()

func get_attack_animation() -> String:
	match attack_index:
		0: return "attack_1"
		1: return "attack_2"
		2: return "attack_3"
	
	return "attack_1"


func enable_damage_box(index: int) -> void:
	match index:
		0: attack_1.monitoring = true
		1: attack_2.monitoring = true
		2: attack_3.monitoring = true


func disable_damage_box() -> void:
	attack_1.monitoring = false
	attack_2.monitoring = false
	attack_3.monitoring = false


func _on_attack_1_area_entered(area: Area2D) -> void:
	apply_damage(area, 10)

func _on_attack_2_area_entered(area: Area2D) -> void:
	apply_damage(area, 15)

func _on_attack_3_area_entered(area: Area2D) -> void:
	apply_damage(area, 20)
