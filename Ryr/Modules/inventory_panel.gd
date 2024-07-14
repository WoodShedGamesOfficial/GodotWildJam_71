extends Control

class_name InventoryPanelUI

@export var item_ui_list : Array[ItemUI]

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_item_acquired.connect(on_item_acquired)
	SignalManager.on_item_lost.connect(on_item_lost)

func on_item_acquired(item_id : ItemId.Id):
	for item_ui in item_ui_list :
		if item_ui.is_empty :
			for item_config in ConfigurationManager.item_configuration_list :
				if item_config.item_id == item_id :
					item_ui.initialize(item_config.icon,item_id)
			break

func on_item_lost(item_id : ItemId.Id) :
	for item_ui in item_ui_list :
		if !item_ui.is_empty && item_ui.item_id == item_id :
			item_ui.reset_ui()

func reset_ui():
	for item_ui in item_ui_list :
		item_ui.reset_ui()
