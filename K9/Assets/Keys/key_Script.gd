extends Node2D

@export var key_name = 'Key_0'
@export_multiline var key_description  = 'Key description here'
@onready var pickup_area = $Sprite2D/PickupArea

@export_multiline var Pickup_text : PackedStringArray = [
	"oh man 32 missed messages?",
	"Thats weird I usually have signal here.",
	"I should check my calendar in the kitchen",
	]

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
	#var player = get_tree().current_scene.get_node_or_null('PC')
	
	if body.is_in_group('player'):
		K9GlobalItemList.key_list[key_name] = key_description
		K9GlobalItemList.key_array.append(key_name)
		
		play_dialogue()
		$Sprite2D/PickupArea.monitoring = false
		visible = false
		
		#print('keys list: ' + str(K9GlobalItemList.key_list))
		#queue_free()
	pass
	
func play_dialogue():
	var player = get_tree().current_scene.get_node_or_null('PC')
	var current_line : int
	var next_line : int
	
	current_line = 0
	for lines in Pickup_text.size():
		player.show_dialogue_box(Pickup_text[current_line])
		next_line = current_line + 1
		await get_tree().create_timer(5.0).timeout
		current_line = next_line
	
	
	pass
	
