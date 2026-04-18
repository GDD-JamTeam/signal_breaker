extends base_entity

# variables
@export var charge_time: float = 1.0
@export var rest_time: float = 1.5

var on_range: bool = false
var is_alive: bool = true
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


func change_state(new_state: State) -> void:
	timer = 0.0
	state = new_state


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
