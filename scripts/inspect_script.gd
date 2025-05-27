extends Control

@onready var name_label = $MarginContainer/HBoxContainer/TextVboxLeft/name
@onready var type_label = $MarginContainer/HBoxContainer/TextVboxLeft/type
@onready var condition_label = $MarginContainer/HBoxContainer/TextVboxLeft/condition
@onready var legal_label = $MarginContainer/HBoxContainer/TextVboxLeft/legal
@onready var weight_label = $MarginContainer/HBoxContainer/TextVboxLeft/weight
@onready var value_label = $MarginContainer/HBoxContainer/TextVboxLeft/value
@onready var item_image = $MarginContainer/HBoxContainer/ItemImage
@onready var description_label = $MarginContainer/HBoxContainer/TextVboxRight/description


func _process(delta: float) -> void:
	if Signals.inspect_ui_shown == true:
		update_inspect_panel()

func update_inspect_panel():
	var item_id = Signals.dragged_item
	var item_name =  str(Apeloot.items[item_id]["name"])
	var item_type = Apeloot.items[item_id]["type"]
	var item_condition = Apeloot.items[item_id]["condition"]
	var item_legal = Apeloot.items[item_id]["legality"]
	if item_id != "":
		item_image.texture = load(Apeloot.ITEM_ICONS_PATH + item_id + ".png")
		name_label.text = item_name
		type_label.text = "Type: " + Apeloot.typies[item_type]["name"]
		condition_label.text = "Condition: " + Apeloot.conditionies[item_condition]["name"]
		legal_label.text = "Legality: " + Apeloot.legalities[item_legal]["name"]
		weight_label.text = "Weight: " + str(Apeloot.items[item_id]["weight"]) + " kg"
		value_label.text = "Value: " + str(Apeloot.items[item_id]["price"])
		description_label.text = str(Apeloot.items[item_id]["desc"])
	else:
		pass
