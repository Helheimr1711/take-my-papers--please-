extends Control

#Data
const Key_textures_path = "res://assets/key_textures/"


var texture_rect:
	get():
		return $MarginContainer/key_bind_texture

func _process(delta: float) -> void:
	var key = Signals.keybind_tooltip
	if key != "":
		texture_rect.texture = load(Key_textures_path + key + "_key.jpg")
	else:
		texture_rect.texture = null
