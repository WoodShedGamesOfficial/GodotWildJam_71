extends Sprite2D

@export var Item_Name : String
@export_multiline var text_to_read : PackedStringArray
@onready var area_2d = $Area2D #requires area 2d child

var current_line : int
var key_ring_size = K9GlobalItemList.key_array.size()

@export var requires_trigger : bool = false
@export var required_key : String
var is_interactable : bool 

@onready var player = get_tree().current_scene.get_node_or_null('PC')

func _ready():
	area_2d.connect("body_entered", check)
	pass
	

func _input(event):
	if Input.is_action_just_pressed("Player_interact") and is_interactable:
		interact()
	pass
	

func check(body):
	if body.is_in_group("player"):
		match requires_trigger:
			true:
				if K9GlobalItemList.key_array.has(required_key):
					is_interactable = true
			false:
				is_interactable = true
	pass
	

func interact():
	player.show_dialogue_box(text_to_read)
	#print('ere we go!')
	pass
	
