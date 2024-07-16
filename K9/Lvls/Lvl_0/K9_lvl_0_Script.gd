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
	
	$Ticker.connect('timeout', tick)
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("Dev_Button"):
		$AbientLight.color = Time_of_Day["Night_Time"]
	pass
	


func tick():
	
	pass
