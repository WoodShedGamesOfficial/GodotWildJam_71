extends CanvasLayer

class_name ItemDetailPopup
@onready var item_model = $ItemDetailPanel/ItemModel
@onready var item_name = $ItemDetailPanel/ItemName
@onready var item_description = $ItemDetailPanel/ItemDescription
@onready var animation_player = $ItemDetailPanel/AnimationPlayer

func initialize(item_configuration : ItemConfiguration):
	item_model.texture = item_configuration.icon
	item_name.text = item_configuration.item_name
	item_description.text = item_configuration.description
	
	animation_player.play("Active")
	visible = true

func close():
	animation_player.play("None")
	visible = false

func _on_close_button_pressed():
	close()
