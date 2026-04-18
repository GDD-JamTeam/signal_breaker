extends Label

var hits:int = 0

func _ready() -> void:
	# Conectar con señal de cuando recibe daño un enemigo
	pass 

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		actualizar_contador()
	
func actualizar_contador():
	var tween_pop = get_tree().create_tween()
	#var tween_shrink = get_tree().create_tween()
	
	tween_pop.tween_property(self, "scale", scale*2, 0.1)
	tween_pop.tween_property(self, "scale", Vector2.ONE, 0.1)
	hits += 1
	self.text = str(hits) + "x"
