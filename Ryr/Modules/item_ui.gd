extends TextureRect

class_name ItemUI

var is_empty : bool = true
var item_id : ItemId.Id = ItemId.Id.NONE

func initialize(item_texture : Texture2D, item_id : ItemId.Id) :
	texture = item_texture
	self.item_id = item_id
	
	is_empty = false

func reset_ui():
	texture = null
	item_id = ItemId.Id.NONE
	
	is_empty = true
