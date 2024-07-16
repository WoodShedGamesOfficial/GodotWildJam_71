#@tool
extends Node2D
class_name K9_DevRoom

##@experimental
##K9's dev room for experimentation and bum fuckery

#//--------------
@onready var sunshine: DirectionalLight2D = $DirectionalLight2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_label_text()
	
	
	
	#print(str(get_viewport_rect().size))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	await get_tree().create_timer(K9Globals.time_tick).timeout
	sunshine.rotation_degrees += 0.01
	pass


func set_label_text():
	var text_label_a: RichTextLabel = $RichTextLabel
	
	var text_file = FileAccess.open("res://K9/Globals/TxtFiles/TextTest.txt", FileAccess.READ)
	var content = text_file.get_as_text()
	
	text_label_a.text = content
	
	pass
	

