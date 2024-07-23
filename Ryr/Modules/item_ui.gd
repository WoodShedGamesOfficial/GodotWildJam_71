extends TextureRect

class_name ItemUI

@onready var model = $MarginContainer/Control/Model
@onready var animation_player = $AnimationPlayer

var is_empty : bool = true
var item_id : ItemId.Id = ItemId.Id.NONE

var is_selected : bool = false

func initialize(item_texture : Texture2D, item_id : ItemId.Id) :
	model.texture = item_texture
	self.item_id = item_id
	
	is_empty = false

func reset_ui():
	model.texture = null
	item_id = ItemId.Id.NONE
	
	is_empty = true

func set_selected(is_selected : bool) :
	self.is_selected = is_selected
	
	animation_player.play("None" if !is_selected else "Selected")
