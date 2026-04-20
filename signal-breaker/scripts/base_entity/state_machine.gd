extends StateMachine


## Entidad a controlar
@export var entity: BaseEntity

func _ready():
	super()
	if entity is BaseEntity:
		entity.damaged.connect(_on_entity_damaged)


func _on_entity_damaged(damage: int, source_position: Vector2):
	if current_state and current_state.has_method("on_damaged"):
		current_state.on_damaged(damage, source_position)


func change_to_state(next_state: Script) -> void:
	# Sobrescribe el metodo de transición para poder establecer el estado anterior
	super(next_state)

	# Establece el método anterior
	entity.previous_state = next_state
