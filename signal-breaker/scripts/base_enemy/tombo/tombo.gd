class_name tombo extends BaseEnemy

@export_group("Ticket Config")
@export var fire_node: Node2D
@export var ticket: PackedScene

# 🔥 Configuración del disparo
@export var projectile_count: int = 3
@export var spread_angle: float = 45.0

@export var ticket_damage: float = 20

func fire_tickets() -> void:
	if not player:
		return
	
	# 🔹 Determinar dirección horizontal (izquierda / derecha)
	var dir_x : int = sign(player.global_position.x - fire_node.global_position.x)
	
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
		var angle := start_angle + step * i
		
		# Rotamos sobre el eje horizontal
		var dir := base_dir.rotated(angle)
		
		spawn_projectile(dir)


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
