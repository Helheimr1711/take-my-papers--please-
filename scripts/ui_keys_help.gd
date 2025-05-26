extends Control

#Data
const Key_textures_path = "res://assets/key_textures/"


var texture_rect:
	get():
		return $PanelContainer/key_bind_texture

func _process(delta: float) -> void:
	var key = Signals.keybind_tooltip
	if key != "":
		texture_rect.texture = load(Key_textures_path + key + "_key.jpg")
		print(Key_textures_path + key + "_key.jpg")
		print(key)
	else:
		texture_rect.texture = null
