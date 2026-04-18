extends StateMachine


## Entidad a controlar
@export var entity: BaseEntity


func change_to_state(next_state: Script) -> void:
	# Sobrescribe el metodo de transición para poder establecer el estado anterior
	super(next_state)

	# Establece el método anterior
	entity.previous_state = next_state
