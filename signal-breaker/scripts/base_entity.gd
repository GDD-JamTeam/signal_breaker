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
var is_knocked: bool = false
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
	if not is_alive:
		return
	
	health -= damage
	
	var knockback_dir = (global_position - source_position).normalized()
	velocity = knockback_dir * knockback_force
	
	is_knocked = true
	knockback_timer = knockback_duration
	
	if health <= 0:
		die()

func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if is_knocked:
		knockback_timer -= delta
		
		if knockback_timer <= 0:
			is_knocked = false
	
	move_and_slide()
