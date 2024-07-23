extends Control
class_name K9_menu_controller

@onready var Credits_Screen = $Credits_Screen
@onready var Start_Menu = $StartMenu



# Called when the node enters the scene tree for the first time.
func _ready():
	connect_menu_interface()
	settup_UI()
	
	$AnimationPlayer.play('Fade')
	
	get_tree().paused = false
	pass # Replace with function body.

func start_the_game():
	K9Globals.level_path_to_load = load("res://K9/Lvls/Lvl_0/K9_lvl_0.tscn")
	var loading_screen_p = load("res://K9/Lvls/LoadingScreen/loading_screen.tscn")
	
	get_tree().change_scene_to_packed(loading_screen_p)
	pass
	


func settup_UI(): # hides menus that shouldnt be seen early
	
	if Credits_Screen.visible != false:
		Credits_Screen.visible = false
	
	if Start_Menu.visible != false: 
		Start_Menu.visible = false
	
	
	if $OptionsScreen.visible != false:
		$OptionsScreen.visible = false
	
	pass

func show_start_menu(): # just does it all
	if Start_Menu.visible != true:
		Start_Menu.visible = true
	else:
		Start_Menu.visible = false
	pass

func toggle_credits_panel():
	if Credits_Screen.visible != true:
		Credits_Screen.visible = true
	else:
		Credits_Screen.visible = false
	pass


func quit_game():
	get_tree().quit()
	pass

func connect_menu_interface(): #connect buttons for PC use
	var s_back = $StartMenu/Start_menu/SBack
	var start_game = $MMSelections/startgame
	
	$StartMenu/Start_menu/Button.connect('pressed', start_the_game)
	s_back.connect('pressed', show_start_menu)
	$MMSelections/startgame.connect('pressed', show_start_menu)
	$MMSelections/Button4.connect('pressed', quit_game)
	$MMSelections/Button3.connect("pressed", toggle_credits_panel)
	
	
	pass
