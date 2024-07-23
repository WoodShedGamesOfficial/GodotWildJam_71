extends Node2D

@export var required_key : String = 'Key_0'
@onready var interactable_area = $Interactable_area

var is_interactable : bool 

#---------

# Called when the node enters the scene tree for the first time.
func _ready():
	interactable_area.connect("body_entered", attempt_to_open_door)
	pass # Replace with function body.


func attempt_to_open_door(body):
	if body.is_in_group("player"):
		is_interactable = true
	if Input.is_action_just_pressed("Player_interact") and is_interactable:
		print('door int')
	pass
	

func _input(event):
	
	if Input.is_action_just_pressed("Player_interact") and is_interactable:
			for key in K9GlobalItemList.key_list:
				if key == required_key:
					open_door()
	
	pass
	

func open_door():
	queue_free()
	pass
	
