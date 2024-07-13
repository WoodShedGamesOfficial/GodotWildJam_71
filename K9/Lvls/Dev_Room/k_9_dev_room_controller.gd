@tool
extends Node2D
class_name K9_DevRoom

##@experimental
##K9's dev room for experimentation and bum fuckery

#//--------------
@onready var sunshine: DirectionalLight2D = $DirectionalLight2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	sunshine.rotation_degrees += 0.01
	pass
