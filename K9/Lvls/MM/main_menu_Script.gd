extends Control
class_name K9_menu_controller

@onready var Credits_Screen = $Credits_Screen
@onready var Start_Menu = $Start_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_menu_interface()
	settup_UI()
	

	
	
	pass # Replace with function body.


func settup_UI(): # hides menus that shouldnt be seen early
	if Credits_Screen.visible != false:
		Credits_Screen.visible = false
	
	if Start_Menu.visible != false: 
		Start_Menu.visible = false
	pass

func show_start_menu(): # just does it all
	Start_Menu.visible = true
	pass

func toggle_credits_panel():
	Credits_Screen.visible = true
	pass


func quit_game():
	get_tree().quit()
	pass

func connect_menu_interface(): #connect buttons for PC use
	$MMSelections/Button.connect('pressed', show_start_menu)
	$MMSelections/Button4.connect('pressed', quit_game)
	$MMSelections/Button3.connect("pressed", toggle_credits_panel)
	
	
	pass
