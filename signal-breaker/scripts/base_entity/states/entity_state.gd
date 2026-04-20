class_name EntityState extends BaseState


## Envoltorio para la entidad base
var base_entity: BaseEntity:
	get:
		return controlled_node as BaseEntity
	set(value):
		controlled_node = value


func on_damaged(_damage: int, _source_position: Vector2) -> void:
	to_state.emit(EntityStunned)
