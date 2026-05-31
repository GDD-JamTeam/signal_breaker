# SoundManager.gd
extends Node

## El diccionario que actúa como librería (Llave: String -> Valor: AudioStream)
@export var sound_library: Dictionary = {
	# "tag": preload("file"),
}

## Función global para obtener un sonido de manera segura
func get_sound(key: String) -> AudioStream:
	if sound_library.has(key):
		return sound_library[key]

	push_warning("SoundManager: La llave de audio '" + key + "' no existe en la librería.")
	return null
