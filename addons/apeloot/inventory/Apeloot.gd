extends Node

#Signals
signal item_added(to_inv: GridInventory, item: DraggableItem)
signal item_removed(from_inv: GridInventory, item: DraggableItem)
signal item_updated(in_inv: GridInventory, item: DraggableItem)

#Startup
var inventory_refs := {}
@onready var temp_node = Control.new()
func _ready():
	add_child(temp_node)

#Data
enum Rarity {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}
enum Item_Type {Weapon, Consumable, Contraband, Document, Valuable, Junk, Ammo}
enum Legality {Legal, Ilegal}
enum Condition {New, Worn, Damaged, Broken, Fake, Expired}
const ITEM_ICONS_PATH := "res://addons/apeloot/image/examples/"
const INVENTORY_ITEM_SIZE := Vector2(56,56)
const item_patterns = {
	"1x1": [[1]],
	"2x2": [
		[1, 1],
		[1, 1]
	],
	"1x2": [
		[0,1],
		[0,1]
	],
	"2x1": [
		[0,0],
		[1,1],	
	],
	"3x3": [
		[1, 1, 1],
		[1, 1, 1],
		[1, 1, 1]
	],
	"3x1": [
		[0, 0, 0],
		[1, 1, 1],
		[0, 0, 0],
	],
	"T": [
		[1, 1, 1],
		[0, 1, 0],
		[0, 1, 0]
	],
	"diagonal": [
		[0,1],
		[1,0]
	],
	"diagonal3": [
		[0,0,1],
		[0,1,0],
		[1,0,0],
	],
	"reverse_diagonal": [
		[1,0],
		[0,1],
	]
}

const rarities := {
	Rarity.COMMON: {"name": "Common", "color": Color.WHITE, "chance": 0.6},
	Rarity.UNCOMMON: {"name": "Uncommon", "color": Color.GREEN_YELLOW, "chance": 0.25},
	Rarity.RARE: {"name": "Rare", "color": Color.DODGER_BLUE, "chance": 0.1},
	Rarity.EPIC: {"name": "Epic", "color": Color.MEDIUM_PURPLE, "chance": 0.04},
	Rarity.LEGENDARY: {"name": "Legendary", "color": Color.ORANGE_RED, "chance": 0.01},
}

const legalities := {
	0: {"name": "Legal"},
	1: {"name": "Ilegal"},
}

const typies := {
	0: {"name": "Weapon"},
	1: {"name": "Consumable"},
	2: {"name": "Contraband"},
	3: {"name": "Document"},
	4: {"name": "Valuable"},
	5: {"name": "Junk"},
	6: {"name": "Ammunation"},
}

const conditionies := {
	0: {"name": "New"},
	1: {"name": "Worn"},
	2: {"name": "Damaged"},
	3: {"name": "Broken"},
	4: {"name": "Fake"},
	5: {"name": "Expired"},
}

const items := {
	"ammo-pack": {
		"name": "Ammo-Pack",
		"desc": "Basic pack of ammunation for all weapons.",
		"price": 31,
		"rarity": Rarity.COMMON,
		"pattern": "1x1",
		"merge": true,
		"type": Item_Type.Ammo,
		"weight": 0.2,
		"condition": Condition.New,
		"legality": Legality.Ilegal
		
	},
	"pickaxe": {
		"name": "Pickaxe",
		"desc": "A test item that was drawn in paint.",
		"price": 50,
		"rarity": Rarity.COMMON,
		"pattern": "T",
		"merge": true,
	},
	"ketchup": {
		"name": "Ketchup",
		"desc": "Goes well with steak.",
		"price": 10,
		"rarity": Rarity.UNCOMMON,
		"stack": 66,
	},
	"glasses": {
		"name": "Glasses?",
		"desc": "I don't know what this is.",
		"price": 31,
		"rarity": Rarity.COMMON,
		"pattern": "diagonal",
		"merge": true,
	},
}
