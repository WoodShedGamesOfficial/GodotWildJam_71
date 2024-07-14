extends CharacterBody2D


const SPEED = 120.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# for moving purposes
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction : 
		velocity = direction * SPEED
	else :
		velocity = Vector2.ZERO
	
	move_and_slide()
	#
	
	# for interact
	if Input.is_action_just_pressed("interact") :
		interact()
	#

#region interactor

@export var interactor_area : Area2D 

func interact():
	var overlapping_areas = interactor_area.get_overlapping_areas()
	
	if overlapping_areas.size() <= 0 : return
	
	for area in overlapping_areas :
		if area is IInteractable :
			area.interact(self)

#endregion
