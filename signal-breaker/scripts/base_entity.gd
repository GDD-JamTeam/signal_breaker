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
var last_direction: int = 1
var attack_index: int = 0

@export var knockback_force: float = 200.0
@export var knockback_duration: float = 0.2
@export var health: int = 100
@export var speed: int
@export var animation_sprite: AnimatedSprite2D

func _ready() -> void:
	pass

func move_to(pos: Vector2) -> void:
	var dir = (pos - global_position).normalized()
	move_direction(dir)
	
func move_direction(dir: Vector2) -> void:
	if state == State.STUNNED:
		return
	
	if dir.x != 0:
		last_direction = sign(dir.x)
	
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
	
	if knockback_dir.x != 0:
		last_direction = sign(knockback_dir.x)
	
	velocity = knockback_dir * knockback_force
	
	change_state(State.STUNNED)
	knockback_timer = knockback_duration
	
	if health <= 0:
		die()
		
func update_animation() -> void:
	var new_anim: String
	
	match state:
		State.STUNNED:
			new_anim = "hurt"
		
		State.ATTACK:
			new_anim = get_attack_animation()
		
		_:
			if velocity.length() > 10:
				new_anim = "walk"
			else:
				new_anim = "idle"
	
	if animation_sprite.animation != new_anim:
		animation_sprite.play(new_anim)
	
	animation_sprite.flip_h = last_direction < 0
	
func get_attack_animation() -> String:
	return "attack"
	
func exit_stunned():
	pass
	
func _on_AnimatedSprite2D_animation_finished():
	if state == State.ATTACK:
		change_state(State.SEEKING) # enemigo
		# o IDLE en player

func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if State.STUNNED:
		knockback_timer -= delta
		
		if knockback_timer <= 0:
				exit_stunned()
	
	move_and_slide()
