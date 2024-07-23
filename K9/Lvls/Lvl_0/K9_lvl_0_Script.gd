extends Node2D

@onready var pc_text_box = $PC/CanvasLayer/PC_UI/Text_Box
@onready var player = get_node_or_null("PC")

@onready var level_anims = $Level_Anims

#Time of Day
var Time_of_Day = {
	"Night_Time" :
		Color(0.216, 0.008, 0.357),
	'Morning' :
		Color(1, 0.804, 0.576),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#K9GlobalItemList.key_array.append('Calendar')
	$"TheHouse/1stPhase/Decor/BedB".connect('player_slept', fade_anim)
	
	$AbientLight.color = Time_of_Day['Morning']
	$"TheHouse/1stPhase/FogOfWar/InvisiWall_0".visible = true
	
	pc_text_box.hide_text()
	pc_text_box.hide_box()
	
	#$Ticker.connect('timeout', tick)
	$Crows_Audio/CrowTime.connect('timeout', crow_audio)
	$"TheHouse/1stPhase/Decor/Door".connect('front_door_attempted', front_door_triggered)
	$"TheHouse/1stPhase/Decor/Door".connect('looking_for_FD_key', spawn_key)
	
	K9Globals.current_task = "I need to check the calendar after finding my phone"
	
	$Level_Anims.play('Fade_In')
	await $Level_Anims.animation_finished
	opening_cinematic()
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("Dev_Button"):
		$AbientLight.color = Time_of_Day["Night_Time"]
	pass
	

func opening_cinematic():

	var text_to_read : String
	var invisi_wall = $"TheHouse/1stPhase/FogOfWar/InvisiWall_0"
	 
	$Lvl_0_BK_Stream.playing = true
	text_to_read = "what a great concert last night, I hope we all meet again!"
	$PC.show_dialogue_box(text_to_read)
	await (get_tree().create_timer(8.0).timeout)
	text_to_read = "I should go find my phone"
	K9Globals.current_task = "I need to check if anyone tried to find me last night"
	$PC.show_dialogue_box(text_to_read)
	var cell_phone_p = load("res://K9/Assets/Keys/PhoneKey.tscn")
	var cell = cell_phone_p.instantiate()
	get_tree().current_scene.add_child(cell)
	cell.position = $"TheHouse/1stPhase/Keys/PhoneSpawn".position
	invisi_wall.queue_free()
	#print('spwned phone')
	#await (get_tree().create_timer(25.0).timeout)
	
	pass

func spawn_key(key_p : PackedScene, spawn_point : Vector2):
	var key = key_p.instantiate()
	get_tree().current_scene.add_child(key)
	key.position = spawn_point
	print('spwn keys')
	pass

func front_door_triggered():
	var text_to_read : String
	
	text_to_read = 'what the hell, why is my deadbolt flipped?'
	$PC.show_dialogue_box(text_to_read)
	await (get_tree().create_timer(8.0).timeout)
	text_to_read = 'I need to find the key to the front door'
	$PC.show_dialogue_box(text_to_read)
	await (get_tree().create_timer(8.0).timeout)
	
	if K9GlobalItemList.key_array.has("required_key"):
		advance_game_stage()
	pass
	

func crow_audio():
	$Crows_Audio/CrowTime.wait_time = randf_range(15, 60)
	$Crows_Audio.playing = true
	pass

func fade_anim():
	$Level_Anims.play_backwards("Fade_In")
	await get_tree().create_timer(3.0).timeout
	$Level_Anims.play("Fade_In")
	pass


func advance_game_stage():
	var L_Anim = $Level_Anims
	L_Anim.play_backwards('Fade_In')
	await L_Anim.animation_finished
	spawn_demon()
	var text_to_read = "what the hell just happened? I was just at my door?"
	$"TheHouse/2ndPhase".visible = true
	$AbientLight.color = Color(0.216, 0.008, 0.357)
	player.show_dialogue_box(text_to_read)
	player.position = Vector2(-32, 28)
	L_Anim.play("Fade_In")
	pass
	

@onready var monster_p = load('res://K9/Assets/SleepDemon/sleep_demon.tscn')

func spawn_demon():
	var monster = monster_p.instantiate()
	
	get_tree().current_scene.add_child(monster)
	monster.position = $TheHouse/MonsterSpawnPoint.position
	
	print('spawned sleep demon' + str(monster.position))
	
	pass
	

func _on_door_start_next_stage():
	evolve_map()
	$AbientLight.color = Color(0.216, 0.008, 0.357)
	$Lvl_0_BK_Stream.stream = stream_music
	pass # Replace with function body.

var stream_music = load("res://K9/Modules/Audio/SIIIICK.ogg")

func evolve_map():
	level_anims.play('Fade_In')
	await level_anims.animation_finished
	advance_game_stage()
	level_anims.play_backwards('Fade_In')
	await level_anims.animation_finished
	$"TheHouse/1stPhase/FogOfWar/UnusedBedroom".visible = false
	$"TheHouse/1stPhase/FogOfWar/OfficeFogOfWar".visible = false
	$"TheHouse/1stPhase".erase_cell(0 ,Vector2i(16, -3))
	$"TheHouse/1stPhase".erase_cell(0 ,Vector2i(16, -4))
	
	$AbientLight.color = Color(0.216, 0.008, 0.357)
	print('changedTileMap')
	pass

var MM_P = load("res://K9/Lvls/MM/main_menu.tscn")

func _on_door_beat_the_game():
	#$"You win!".visible = true
	$"PC/CanvasLayer/PC_UI/You win!".visible = true
	get_tree().paused = true
	await get_tree().create_timer(35.0).timeout
	get_tree().change_scene_to_packed(MM_P)
	pass # Replace with function body.
