extends CharacterBody2D


const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#-----------------
	var h_direction = Input.get_axis("ui_left", "ui_right")
	var v_direction = Input.get_axis('ui_up', 'ui_down')
	
	if h_direction:
		velocity.x = h_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if v_direction:
		velocity.y = v_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	#------------
	
	move_and_slide()
	pass
	

func _process(delta):
	monitor_mouse_position()
	#-------
	
	
	#light follows mouse_pos
	$PCHand.look_at(get_global_mouse_position())
	pass
	

func monitor_mouse_position(): #"rotate" player sprite
	var mouse_pos: Vector2 = get_global_mouse_position()
	var screensize_x = get_viewport().get_visible_rect().size.x
	var screensize_y = get_viewport().get_visible_rect().size.y
	
	if mouse_pos.x > (screensize_x / 2):
		$CapsuleGreybox.flip_h = false
	else:
		$CapsuleGreybox.flip_h = true
	pass
	

