extends Node2D

@onready var pc_text_box = $PC/CanvasLayer/PC_UI/Text_Box

#Time of Day
var Time_of_Day = {
	"Night_Time" :
		Color(0.216, 0.008, 0.357),
	'Morning' :
		Color(1, 0.804, 0.576),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$AbientLight.color = Time_of_Day['Morning']
	
	pc_text_box.hide_text()
	pc_text_box.hide_box()
	
	#$Ticker.connect('timeout', tick)
	$Crows_Audio/CrowTime.connect('timeout', crow_audio)
	$"TheHouse/1stPhase/Decor/Door".connect('front_door_attempted', front_door_triggered)
	
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
	 
	$Lvl_0_BK_Stream.playing = true
	text_to_read = "what a night last night, I hope we meet again!"
	$PC.show_dialogue_box(text_to_read)
	await (get_tree().create_timer(8.0).timeout)
	text_to_read = "I should go find my phone"
	$PC.show_dialogue_box(text_to_read)
	var cell_phone_p = load("res://K9/Assets/Keys/PhoneKey.tscn")
	var cell = cell_phone_p.instantiate()
	get_tree().current_scene.add_child(cell)
	cell.position = $"TheHouse/1stPhase/Keys/PhoneSpawn".position
	$"TheHouse/1stPhase/Decor/InvisiWall_0".queue_free()
	#print('spwned phone')
	await (get_tree().create_timer(25.0).timeout)
	text_to_read = "Those Horns at the concert were nuts, how did they do that?"
	$PC.show_dialogue_box(text_to_read)
	pass

func front_door_triggered():
	var text_to_read : String
	
	text_to_read = 'what the hell, why is my deadbolt flipped?'
	$PC.show_dialogue_box(text_to_read)
	await (get_tree().create_timer(8.0).timeout)
	text_to_read = 'I need to find the key to the front door'
	$PC.show_dialogue_box(text_to_read)
	await (get_tree().create_timer(8.0).timeout)
	pass
	

func crow_audio():
	$Crows_Audio/CrowTime.wait_time = randf_range(15, 60)
	$Crows_Audio.playing = true
	pass
