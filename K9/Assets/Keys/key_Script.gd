extends Node2D

@export var key_name = 'Key_0'
@export_multiline var key_description  = 'Key description here'
@onready var pickup_area = $Sprite2D/PickupArea

signal picked_up_key

# Called when the node enters the scene tree for the first time.
func _ready():
	pickup_area.connect('body_entered', pickup_key)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@export var text_to_read : String
func pickup_key(body):
	
	if body.is_in_group('player'):
		K9GlobalItemList.key_list[key_name] = key_description
		if body.has_method('show_dialogue_box'):
			body.show_dialogue_box(text_to_read)
		
		print('keys list: ' + str(K9GlobalItemList.key_list))
		queue_free()
	pass
	
