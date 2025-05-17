extends Node2D

@onready var IconRect_path = $Icon

var item_id : int
var item_grids := []
var selected = false
var grid_anchor = null


func _process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func load_item(a_item_id : int) -> void:
	var icon_path = "res://test_inventory_assets/" + DataHandler.item_data[str(a_item_id)]["Name"] + ".png"
	IconRect_path.texture = load(icon_path)
	for grid in DataHandler.item_grid_data[str(a_item_id)]:
		var converter_array := []
		for i in grid:
			converter_array.push_back(int(i))
		item_grids.push_back(converter_array)
