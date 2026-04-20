class_name Player extends BaseEntity


signal get_hurt_signal()
signal hit()
signal die_signal()


## Frames a los que se ataca, como rangos
var attack_frames = [
	[2, 3], # attack_1
	[4, 6], # attack_2
	[6, 9], # attack_3
]


## Lista de hitboxes
@export var hitboxes: Array[Area2D]
## Lista de daños que hacen las hitboxes, en el mismo orden
@export var hitboxes_damage: Array[int] = [10, 15, 20]


## Dirección de entrada
var input_dir: Vector2

func _ready() -> void:
	# Desactiva los hitboxes
	disable_hitboxes()

	# Conecta los hitboxes a la función de daño con su valor correspondiente
	for i in hitboxes.size():
		var hitbox = hitboxes[i]
		var hitbox_damage = hitboxes_damage[i]
		hitbox.area_entered.connect(apply_damage.bind(hitbox_damage))


func _physics_process(delta: float) -> void:
	super(delta)

	# Actualiza la entrada de teclado
	input_dir = Input.get_vector("left", "right", "up", "down")


## Activa la hitbox indicada para dar daño
func enable_hitbox(index: int) -> void:
	hitboxes[index].set_deferred("monitoring", true)
	hitboxes[index].visible = true
	hitboxes[index].set_deferred("monitorable", true)


## Desactiva las hitbox cuando no se ataca
func disable_hitboxes() -> void:
	for hitbox in hitboxes:
		hitbox.set_deferred("monitoring", false)
		hitbox.visible = false
		hitbox.set_deferred("monitorable", false)


## Obtiene el rango de frames de ataque
func get_attack_frame_range() -> Array:
	return attack_frames[attack_index]


func get_health():
	return health


func get_hurt(damage: int, source_position: Vector2) -> void:
	super(damage, source_position)
	get_hurt_signal.emit()


## Avisa de la muerte del jugador y muere
func die() -> void:
	die_signal.emit()
	super()


func apply_damage(area: Area2D, damage: int) -> void:
	var before := hit_targets.size()

	super(area, damage)

	var after := hit_targets.size()

	if after > before:
		var _target = area.get_parent()
		hit.emit()
