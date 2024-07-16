extends Panel

@onready var text_start = $TextStart
@onready var text_body = $TextBody
@onready var text_end = $TextEnd



# Called when the node enters the scene tree for the first time.
func _ready():
	
	#hide_text()
	
	
	pass # Replace with function body.
	

func set_text(text_body_p):
	
	var text = FileAccess.open(text_body_p, FileAccess.READ)
	text_body.text = str(text)
	
	pass
	

func hide_text():
	text_start.visible = false
	text_body.visible = false
	text_end.visible = false
	pass
	

func hide_box():
	visible = false
	pass
