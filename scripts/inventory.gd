extends Control

@onready var slot_scene = preload("res://scenes/slot.tscn")
@onready var grid_container = $ColorRect/MarginContainer/VBoxContainer/GridContainer
@onready var item_scene = preload("res://scenes/item.tscn")

var grid_array := []
var item_held = null

func _ready() -> void:
	for i in range(64):
		create_slot()

func create_slot():
	var new_slot = slot_scene.instantiate()
	new_slot.slot_id = grid_array.size()
	grid_container.add_child(new_slot)
	grid_array.push_back(new_slot)
	new_slot.slot_entered.connect(_on_slot_mouse_entered)
	new_slot.slot_exited.connect(_on_slot_mouse_exited)

func _on_slot_mouse_entered(a_Slot):
	a_Slot.set_color(a_Slot.States.TAKEN)
func _on_slot_mouse_exited(a_Slot):
	a_Slot.set_color(a_Slot.States.DEFAULT )

func _on_spawn_button_pressed() -> void:
	var new_item = item_scene.instantiate()
	add_child(new_item)
	new_item.load_item(1)
	new_item.selected = true
	item_held = new_item
