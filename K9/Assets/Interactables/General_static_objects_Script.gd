extends Node2D

@export var Item_name : String = "generic Name"
@export var item_description : String = 'generic description'

@onready var interaction_area = $Area2D

var is_interactable : bool

func _ready():
	$Label.text = str(Item_name)
	
	interaction_area.connect("body_entered", check_interaction)
	interaction_area.connect("body_exited", check_interaction)
	pass
	

func _process(delta):
	
	if is_interactable:
		$Label.visible = true
	else:
		$Label.visible = false
	
	if Input.is_action_just_pressed("ui_accept") and is_interactable:
		interact()
	pass
	

func check_interaction(body):
	
	if "body_entered" and body.is_in_group('player'):
		is_interactable = true
		print('interactable')
	elif "body_exited":
		is_interactable = false
		print('interactable no longer')
	
	pass
	

func interact():
	var description_box : RichTextLabel = $RichTextLabel
	
	description_box.text = str(item_description)
	pass
