extends ProgressBar

func _process(delta: float) -> void:
	if value != 0:
		value -= 1
		print("a")
	
	else:
		print("completo")
