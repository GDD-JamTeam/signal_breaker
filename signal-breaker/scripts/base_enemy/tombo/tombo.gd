class_name Tombo extends BaseEnemy


@export_group("Ticket Config")
## Nodo de disparo
@export var fire_node: Node2D
## Ticket a disparar
@export var ticket: PackedScene

## Cantidad de proyectiles a disparar
@export var projectile_count: int = 3
## Ángulo total de dispersión en grados
@export var spread_angle: float = 45.0
## Daño que hace cada ticket
@export var ticket_damage: float = 20


## Dispara los tickets
func fire_tickets() -> void:
	if not target: return

	# 🔹 Determinar dirección horizontal (izquierda / derecha)
	var dir_x: int = sign(target.global_position.x - fire_node.global_position.x)

	# fallback por si están exactamente alineados
	if dir_x == 0:
		dir_x = 1

	var base_dir := Vector2(dir_x, 0)

	# Si solo hay 1 proyectil
	if projectile_count <= 1:
		spawn_projectile(base_dir)
		return

	# 🔹 Spread en radianes
	var total_spread_rad := deg_to_rad(spread_angle)
	var step := total_spread_rad / (projectile_count - 1)
	var start_angle := -total_spread_rad / 2.0

	for i in range(projectile_count):
		# Rotamos sobre el eje horizontal
		var angle := start_angle + step * i
		var dir := base_dir.rotated(angle)

		spawn_projectile(dir)


## Instancia un ticket y lo dispara en la dirección dada
func spawn_projectile(dir: Vector2) -> void:
	var p = ticket.instantiate()

	p.global_position = fire_node.global_position
	p.direction = dir

	# Rotación visual
	p.rotation = dir.angle()

	# Evitar friendly fire
	p.entity_owner = self

	p.damage = ticket_damage

	get_tree().current_scene.add_child(p)
