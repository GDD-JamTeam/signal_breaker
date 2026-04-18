extends CharacterBody2D
class_name base_entity

enum State {
	STUNNED,
	SEEKING,
	CHARGE,
	ATTACK,
	REST
}

# variables
var state: State

@export var health: int = 100
@export var speed: int

func _ready() -> void:
	pass

func move_to(pos: Vector2) -> void:
	var dir = (pos - global_position).normalized()
	move_direction(dir)
	
func move_direction(dir: Vector2) -> void:
	if state == State.STUNNED:
		return
	velocity = dir * speed

func change_state(new_state: State) -> void:
	state = new_state
	
func die() -> void:
	pass
	
func get_hurt() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	

	move_and_slide()
