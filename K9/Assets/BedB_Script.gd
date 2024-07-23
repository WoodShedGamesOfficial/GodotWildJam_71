extends Sprite2D

@onready var area_2d = $Area2D
var is_interactable : bool 

signal player_slept

# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.connect("body_entered", rest_area_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func rest_area_entered(body):
	if body.is_in_group('player') and K9Globals.game_stage > 1:
		is_interactable = true
	pass 
	

func _input(event):
	if Input.is_action_just_pressed('Player_interact') and is_interactable:
		player_sleep()
	pass
	

func player_sleep():
	var player = get_tree().current_scene.get_node_or_null("PC")
	
	#fade out, tick tock noise, fade in
	emit_signal('player_slept')
	await $"../../../../Level_Anims".animation_finished
	player.sleep = player.PC_Stats["sleep_max"]
	if player.sleep < (player.PC_Stats["sleep_max"] / 2):
		K9Globals.lives_left_to_sleep_away -= 1
		print("aged rapidly")
	#print('slept')
	
	
	pass
	

