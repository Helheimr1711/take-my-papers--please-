extends Node

var is_dragging = false
var keybind_tooltip = ""
var dragged_item = ""
var inspect_ui_shown = false
var inspecting = false

func set_is_dragging_true():
	is_dragging = true

func set_is_dragging_false():
	is_dragging = false
