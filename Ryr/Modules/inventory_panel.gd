extends Control

class_name InventoryPanelUI

@export var item_ui_list : Array[ItemUI]

var selected_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_item_acquired.connect(on_item_acquired)
	SignalManager.on_item_lost.connect(on_item_lost)
	
	# initial selected
	item_ui_list[selected_index].set_selected(true)

func _process(delta):
	if Input.is_action_just_pressed("CycleRight") :
		cycle_through_item(1)
	elif Input.is_action_just_pressed("CycleLeft") :
		cycle_through_item(-1)

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

func cycle_through_item(index_offset : int) :
	item_ui_list[selected_index].set_selected(false)
	
	selected_index += index_offset
	
	if selected_index >= item_ui_list.size() :
		selected_index = item_ui_list.size() - 1
	elif selected_index < 0 :
		selected_index = 0
	
	item_ui_list[selected_index].set_selected(true)
