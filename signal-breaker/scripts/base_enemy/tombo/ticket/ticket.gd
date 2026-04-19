extends Area2D

@export var speed: float = 300.0
@export var damage: int = 10
@export var lifetime: float = 2.0

var direction: Vector2 = Vector2.ZERO
var entity_owner = null


func _ready():
	# destruir después de un tiempo
	await get_tree().create_timer(lifetime).timeout
	queue_free()


func _physics_process(delta):
	position += direction * speed * delta


func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("hurtbox"):
		return
	
	var target = area.get_parent()
	print(target, target.get_groups())
	print(entity_owner, entity_owner.get_groups())
	
	# evitar daño a mismo equipo
	if entity_owner and entity_owner.has_method("is_same_team"):
		if entity_owner.is_same_team(target):
			print("exit")
			return
	
	if target.has_method("get_hurt"):
		target.get_hurt(damage, global_position)
	
	queue_free()
