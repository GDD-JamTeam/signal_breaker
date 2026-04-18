extends BaseEntity


## Lista de hitboxes
@export var hitboxes: Array[Area2D]


## Dirección de entrada
var input_dir: Vector2


func _ready() -> void:
	disable_damage_box()


func _physics_process(delta: float) -> void:
	super(delta)

	# Actualiza la entrada de teclado
	input_dir = Input.get_vector("left", "right", "up", "down")


## Activa la hitbox indicada para dar daño
func enable_damage_box(index: int) -> void:
	hitboxes[index].monitoring = true


## Desactiva las hitbox cuando no se ataca
func disable_damage_box() -> void:
	for hitbox in hitboxes:
		hitbox.monitoring = false


## Aplica daño hacia la entidad con el área dada
func apply_damage(area: Area2D, damage: int) -> void:
	if not area.is_in_group("hurtbox"): return

	# Verifica que sea una hitbox válida
	var target = area.get_parent()
	if target in hit_targets or is_same_team(target): return

	# Aplica el daño y lo añade a la lista de objetivos golpeados
	if target.has_method("get_hurt"):
		target.get_hurt(damage, global_position)
		hit_targets.append(target)


func _on_attack_1_area_entered(area: Area2D) -> void:
	apply_damage(area, 10)


func _on_attack_2_area_entered(area: Area2D) -> void:
	apply_damage(area, 15)


func _on_attack_3_area_entered(area: Area2D) -> void:
	apply_damage(area, 20)
