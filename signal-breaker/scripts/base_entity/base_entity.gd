class_name BaseEntity extends CharacterBody2D


## Índice de la animación de ataque
var attack_index: int = 0

# Estado previo de la máquina de estados
var previous_state: Script

## Indica si se está mirando a la derecha. Para las animaciones
var is_looking_right: bool = true

## Lista de objetivos golpeados
var hit_targets: Array ## ! Para el jugador
var hitbox_active: bool = false ## ! Para el jugador

## Tiempo de espera para atacar
@export var charge_duration: float = 0.2

@export var knockback_force: float = 200.0
## Tiempo de aturdimiento
@export var knockback_duration: float = 0.2
@export var health: int = 100
@export var speed: int = 100
@export var animation_sprite: AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	move_and_slide()

# TODO: para el enemigo
func move_to(pos: Vector2) -> void:
	var dir = (pos - global_position).normalized()
	move_direction(dir)


## Mueve la entidad en la dirección que se le diga
func move_direction(dir: Vector2) -> void:
	if dir.x != 0:
		is_looking_right = dir.x < 0

	velocity = dir * speed


## Recibe daño y empuja la entidad en la dirección del golpe
func get_hurt(damage: int, source_position: Vector2) -> void:
	# Desactiva la hurtbox para evitar spam de daño
	disable_hitboxes()

	health -= damage

	# Empuja al jugador desde donde se le golpe+o
	var knockback_dir = (global_position - source_position).normalized()
	if knockback_dir.x != 0: is_looking_right = knockback_dir.x < 0

	velocity = knockback_dir * knockback_force
	if health <= 0: die()


## Muere la entidad
func die() -> void:
	print("[BaseEntity] Muere la entidad %s" % name)
	queue_free()


## Verifica que el objetivo a golpear sea del mismo equipo
func is_same_team(target: Node) -> bool:
	if is_in_group(&"player") and target.is_in_group(&"player"): return true
	if is_in_group(&"enemy") and target.is_in_group(&"enemy"): return true

	return false


#region Métodos vacíos (para implementar)


## Activa la hurtbox para recibir daño
@warning_ignore("unused_parameter")
func enable_hitbox(index: int) -> void:
	pass


## Desactiva la hurtbox para invulnerabilidad
func disable_hitboxes() -> void:
	pass


## Retorna el rango de frames de ataque
func get_attack_frame_range() -> Array:
	return []


#endregion
