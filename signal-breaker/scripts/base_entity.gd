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
var state: State = State.SEEKING
var previous_state: State

var knockback_timer: float = 0.0
var last_direction: int = 1
var attack_index: int = 0

var hit_targets := []

@export var knockback_force: float = 200.0
@export var knockback_duration: float = 0.2
@export var health: int = 100
@export var speed: int = 100
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
	previous_state = state
	state = new_state


func exit_stunned() -> void:
	change_state(previous_state)


func get_hurt(damage: int, source_position: Vector2) -> void:
	if not is_alive or state == State.STUNNED:
		return
	
	disable_damage_box()
	
	health -= damage
	
	var knockback_dir = (global_position - source_position).normalized()
	
	if knockback_dir.x != 0:
		last_direction = sign(knockback_dir.x)
	
	velocity = knockback_dir * knockback_force
	
	change_state(State.STUNNED)
	knockback_timer = knockback_duration
	
	if health <= 0:
		die()


func apply_damage(area: Area2D, damage: int) -> void:
	if not area.is_in_group("hurtbox"):
		return
	
	var target = area.get_parent()
	
	if target in hit_targets:
		return
	
	if is_same_team(target):
		return
	
	hit_targets.append(target)
	
	if target.has_method("get_hurt"):
		target.get_hurt(damage, global_position)


func reset_hit_targets() -> void:
	hit_targets.clear()


func is_same_team(target: Node) -> bool:
	if is_in_group("player") and target.is_in_group("player"):
		return true
	
	if is_in_group("enemy") and target.is_in_group("enemy"):
		return true
	
	return false


func enable_damage_box(index: int) -> void:
	pass


func disable_damage_box() -> void:
	pass


func get_attack_animation() -> String:
	return "attack"


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


func die() -> void:
	is_alive = false
	queue_free()

func _physics_process(delta: float) -> void:
	if state == State.STUNNED:
		knockback_timer -= delta
		
		if knockback_timer <= 0:
			exit_stunned()
	
	move_and_slide()
	update_animation()


func _on_AnimatedSprite2D_animation_finished() -> void:
	if state == State.ATTACK:
		change_state(State.SEEKING)
