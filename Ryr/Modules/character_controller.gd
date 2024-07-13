extends CharacterBody2D


const SPEED = 120.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction : 
		velocity = direction * SPEED
	else :
		velocity = Vector2.ZERO
	
	move_and_slide()
