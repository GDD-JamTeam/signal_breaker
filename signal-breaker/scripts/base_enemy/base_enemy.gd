class_name BaseEnemy extends BaseEntity


## Frames en los que se activa la hitbox del ataque
@export var attack_frames: Array[int]
## Daño que aplica el enemigo
@export var hurtbox_damage: float = 100.0


## Indica si el jugador está en el rango del enemigo para atacar
var on_range: bool = false
## Objetivo, el jugador
var target: CharacterBody2D = null


@onready var hurtbox: Area2D = $Attacks/hurt_box


func _ready() -> void:
	disable_hitboxes()
	# Busca el jugador
	var players_group = get_tree().get_nodes_in_group(&"player")
	for p in players_group:
		if p is CharacterBody2D:
			target = p
			break

	# Conecta su daño a nuestro enemigo
	hurtbox.area_entered.connect(apply_damage.bind(hurtbox_damage))


## Actualiza la velocidad según la dirección que se le diga
func update_velocity(dir: Vector2) -> void:
	if not is_zero_approx(dir.x):
		is_looking_right = dir.x > 0
	velocity = dir * speed


## Activa la hitbox para dar daño
func enable_hitbox(_index: int) -> void:
	hurtbox.monitoring = true
	hurtbox.visible = true


## Desactiva las hitbox cuando no se ataca
func disable_hitboxes() -> void:
	hurtbox.monitoring = false
	hurtbox.visible = false


## Activa el rango cuando entra un jugador
func _on_attack_range_area_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"player") and body is CharacterBody2D:
		on_range = true


## Desactiva el rango cuando sale un jugador
func _on_attack_range_area_body_exited(body: Node2D) -> void:
	if body.is_in_group(&"player") and body is CharacterBody2D:
		on_range = false


func get_current_attack_frame_range() -> Array:
	return attack_frames
