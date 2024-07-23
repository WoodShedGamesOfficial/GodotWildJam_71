extends Node2D

class_name ItemController

@export var id : ItemId.Id = ItemId.Id.NONE
@export var area : ItemInteractableArea
@onready var model = $Model

func _ready():
	initialize(id)

func initialize(item_id : ItemId.Id):
	id = item_id
	if id != ItemId.Id.NONE :
		for item_config in ConfigurationManager.item_configuration_list :
			if item_config.item_id == id :
				model.texture = item_config.sprite

func on_interacted():
	print("You get " , id)
	SignalManager.on_item_given.emit(self)
	self.queue_free()

