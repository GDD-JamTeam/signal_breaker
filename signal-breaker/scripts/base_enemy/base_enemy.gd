class_name BaseEnemy extends BaseEntity


# variables
var on_range: bool = false
var timer: float = 0.0

@export var attack_frames: Array[int]
@export var hurtbox_damage: float = 100.0

# target
var player: CharacterBody2D = null

@onready var hurtbox: Area2D = $Attacks/hurt_box

func get_on_range() -> bool:
	return on_range

func get_target() -> BaseEntity:
	return player

## Actualiza la velocidad según la dirección que se le diga
func update_velocity(dir: Vector2) -> void:
	if not is_zero_approx(dir.x):
		is_looking_right = dir.x > 0
	velocity = dir * speed

func _ready() -> void:
	disable_hitboxes()
	var players_group = get_tree().get_nodes_in_group("player")
	for p in players_group:
		if p is CharacterBody2D:
			player = p
			break
	hurtbox.area_entered.connect(apply_damage.bind(hurtbox_damage))

## Activa la hitbox para dar daño
func enable_hitbox(_index: int) -> void:
	hurtbox.monitoring = true
	hurtbox.visible = true


## Desactiva las hitbox cuando no se ataca
func disable_hitboxes() -> void:
	hurtbox.monitoring = false
	hurtbox.visible = false

func _on_attack_range_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body is CharacterBody2D:
			on_range = true


func _on_attack_range_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body is CharacterBody2D:
			on_range = false

func get_current_attack_frame_range() -> Array:
	return attack_frames
