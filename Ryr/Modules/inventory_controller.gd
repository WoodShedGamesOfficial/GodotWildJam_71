extends Node2D

class_name InventoryController

var inventory : Array[ItemId.Id] = []
var max_capacity : int = 8

func _ready():
	SignalManager.on_item_given.connect(on_item_given)

func on_item_given(item : ItemController) :
	if inventory.size() >= 8 : return
	
	add_item(item.id)
	item.queue_free()

func add_item(item_id : ItemId.Id):
	if inventory.size() >= 8 : return
	
	inventory.append(item_id)
	SignalManager.on_item_acquired.emit(item_id)

func remove_item(item_id : ItemId.Id) -> ItemId.Id:
	if !inventory.has(item_id) : return ItemId.Id.NONE
	
	inventory.erase(item_id) 
	
	return item_id
