extends Area2D

@export var speed: float = 300.0
@export var damage: int = 10
@export var lifetime: float = 2.0

var direction: Vector2 = Vector2.ZERO
var entity_owner: Node


func _ready():
	# destruir después de un tiempo
	await get_tree().create_timer(lifetime).timeout
	queue_free()


func _physics_process(delta):
	position += direction * speed * delta


func _on_area_entered(area: Area2D) -> void:
	# Consigue información sobre el dueño
	var info := target_info(area)
	if not info: return

	match info.area_type:
		# Hitbox: omite
		&"hitbox": pass
		# Hurtbox: aplica daño si es un rival válido y se va
		&"hurtbox":
			var target: BaseEntity = info.target
			if target.has_method("is_same_team") and target.is_same_team(entity_owner): return
			if target.has_method("get_hurt"): target.get_hurt(damage, global_position)

	queue_free()


## Obtiene el objetivo (padre) de un área y el tipo de área
func target_info(area: Area2D) -> Dictionary:
	# Información
	var info := {}
	info.target = area.get_parent()

	# Debe ser enemigo o jugador, no ambos
	var groups: Array = info.target.get_groups()
	if not &"player" in groups and not &"enemy" in groups: return {}
	if &"player" in groups and &"enemy" in groups: return {}

	print("[Ticket] Target node %s in groups %s" % [info.target, groups])

	info.area_type = &"hitbox" if &"hitbox" in groups else &"hurtbox"

	return info
