class_name Data

extends Resource

var dir:String = "user://save.res"

@export var WASD:Dictionary = {
	up = "W",
	down = "S",
	left = "A",
	right = "D",
	attack_1 = "J",
	attack_2 = "K",
	attack_3 = "L"
}

@export var Arrows:Dictionary = {
	up = "up",
	down = "down",
	left = "left",
	right = "right",
	attack_1 = "z",
	attack_2 = "x",
	attack_3 = "c"
}


func play_WASD() -> void:
	ProjectSettings.set_setting("input/attack_1", WASD)
	ProjectSettings.set_setting("input/attack_2", WASD)
	ProjectSettings.set_setting("input/attack_3", WASD)
	ProjectSettings.set_setting("input/up", WASD)
	ProjectSettings.set_setting("input/down", WASD)
	ProjectSettings.set_setting("input/left", WASD)
	ProjectSettings.set_setting("input/right", WASD)
	

func play_arrows() -> void:
	ProjectSettings.set_setting("input/attack_1", Arrows)
	ProjectSettings.set_setting("input/attack_2", Arrows)
	ProjectSettings.set_setting("input/attack_3", Arrows)
	ProjectSettings.set_setting("input/up", Arrows)
	ProjectSettings.set_setting("input/down", Arrows)
	ProjectSettings.set_setting("input/left", Arrows)
	ProjectSettings.set_setting("input/right", Arrows)
