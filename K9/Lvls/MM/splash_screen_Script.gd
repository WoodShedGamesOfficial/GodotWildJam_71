extends Node2D

@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	fade_in_fade_out()
	pass # Replace with function body.


func fade_in_fade_out():
	anim.play("Fade")
	
	var fade_wait_time: float = 3.0
	await (get_tree().create_timer(fade_wait_time).timeout)
	
	anim.play_backwards("Fade")
	await anim.animation_finished
	
	var MM_path: PackedScene = load("res://K9/Lvls/MM/main_menu.tscn")
	get_tree().change_scene_to_packed(MM_path)
	pass
