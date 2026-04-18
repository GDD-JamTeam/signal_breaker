extends BaseEntity


# variables
@export var charge_time: float = 1.0
@export var rest_time: float = 1.5
@export var attack_area: Area2D
@export var frames_hit: Array[int]

var on_range: bool = false
var timer: float = 0.0

# target
var player: CharacterBody2D = null


func _ready() -> void:
	var players_group = get_tree().get_nodes_in_group("player")
	for p in players_group:
		if p is CharacterBody2D:
			player = p
			break

	change_state(State.SEEKING)


func _process(delta: float) -> void:
	if is_alive and player:
		behavior_tree(delta)


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


func attack() -> void:
	print("Atacando")
	change_state(State.REST)


func exit_stunned():
	change_state(State.SEEKING)

func behavior_tree(delta: float) -> void:
	match state:
		State.SEEKING:
			move_to(player.global_position)

			if on_range:
				change_state(State.CHARGE)


		State.CHARGE:
			timer += delta

			if timer >= charge_time:
				change_state(State.ATTACK)


		State.ATTACK:
			attack()


		State.REST:
			timer += delta

			if timer >= rest_time:
				change_state(State.SEEKING)

		State.STUNNED:
			pass


func get_attack_frame_range() -> Array:
	return frames_hit


func enable_hitbox(_index: int) -> void:
	attack_area.monitoring = true


func disable_hitboxes() -> void:
	attack_area.monitoring = false
