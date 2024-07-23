extends Control

var min_load_time: float = 5.50
@export var level_path: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	level_path = K9Globals.level_path_to_load 
	await get_tree().create_timer(min_load_time).timeout
	get_tree().change_scene_to_packed(level_path)
	pass # Replace with function body.
