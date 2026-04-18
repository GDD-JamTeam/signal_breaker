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
var is_alive: bool = true
var state: State
var knockback_timer: float = 0.0

@export var knockback_force: float = 200.0
@export var knockback_duration: float = 0.2
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
	is_alive = false
	queue_free()
	
func get_hurt(damage: int, source_position: Vector2) -> void:
	if not is_alive or state == State.STUNNED:
		return
	
	health -= damage
	
	var knockback_dir = (global_position - source_position).normalized()
	velocity = knockback_dir * knockback_force
	
	change_state(State.STUNNED)
	knockback_timer = knockback_duration
	
	if health <= 0:
		die()
func exit_stunned():
	pass

func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if State.STUNNED:
		knockback_timer -= delta
		
		if knockback_timer <= 0:
				exit_stunned()
	
	move_and_slide()
