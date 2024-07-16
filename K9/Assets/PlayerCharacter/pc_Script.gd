extends CharacterBody2D

@export var Player_Name: String 

@export var SPEED : float = 150.0

@export var PC_Stats = {
	"sleep_max" :
		100.0,
	'sleep_decay_rate' :
		0.05,
	'bleed_rate' :
		1.0,
}
#const JUMP_VELOCITY = -400.0

var sleep : float 

var player_state = ['alive', 'dying', 'dead']
var current_player_state
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	add_to_group("player")
	
	$AnimatedSprite2D.play('default')
	
	sleep = PC_Stats['sleep_max']
	$SleepTimer.connect('timeout', sleep_tick)
	$SleepTimer.start()
	
	$CanvasLayer/PC_UI/DeathIsntEndScreen.visible = false
	pass
	

func _physics_process(delta):

	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#-----------------
	var h_direction = Input.get_axis("ui_left", "ui_right")
	var v_direction = Input.get_axis('ui_up', 'ui_down')
	
	if h_direction:
		velocity.x = lerp(velocity.x, (h_direction * SPEED), 0.5)
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
	#monitor_mouse_position()
	#-------
	
	$CanvasLayer/PC_UI/SleepBar.value = sleep
	
	#--------- Animations
	
	
	#if velocity.x or velocity.y != 0:
		#$AnimatedSprite2D.play("Walk")
	#else:
		#$AnimatedSprite2D.play("default")
	 
	
	#---
	#light follows mouse_pos
	$PCHand.look_at(get_global_mouse_position())
	
	
	pass
	

func _input(event):
	if Input.is_action_just_pressed("Task_button"):
		var text_to_display = K9Globals.current_task
		show_current_task_hint(text_to_display)
	
	if Input.is_action_pressed('ui_right'):
		$AnimatedSprite2D.play('right')
	elif Input.is_action_pressed('ui_left'):
		$AnimatedSprite2D.play('left')
	elif Input.is_action_pressed('ui_up'):
		$AnimatedSprite2D.play('back')
	elif Input.is_action_pressed('ui_down'):
		$AnimatedSprite2D.play('front')
	else:
		$AnimatedSprite2D.play("Idle")
	pass
	

func show_dialogue_box(text_to_read):
	var D_Box = $MarginContainer
	var D_Box_Label = $MarginContainer/Label
	
	D_Box.visible = true
	D_Box_Label.text = str(text_to_read)
	await get_tree().create_timer(5.0).timeout
	D_Box.visible = false
	pass
	

func monitor_mouse_position(): #"rotate" player sprite
	var mouse_pos: Vector2 = get_global_mouse_position()
	var screensize_x = get_viewport().get_visible_rect().size.x
	var screensize_y = get_viewport().get_visible_rect().size.y
	
	if mouse_pos.x > (screensize_x / 2.0):
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	pass
	

var is_dying : bool

func sleep_tick():
	
	if sleep > 1 and is_dying != true:
		current_player_state = player_state[0]
		sleep -= PC_Stats['sleep_decay_rate']
		
	elif sleep < 0 and is_dying != true:
		current_player_state = player_state[1]
		#$CanvasLayer/PC_UI/DeathIsntEndScreen/TextureProgressBar.value = 50
		second_wind()
		is_dying = true
	
	#await get_tree().create_timer(.5).timeout
	#$CanvasLayer/PC_UI/DeathIsntEndScreen/TextureProgressBar.value -= 0.01
	
	#print(str(sleep))
	pass
	

func second_wind():
	var second_timer = $CanvasLayer/PC_UI/DeathIsntEndScreen/Second_wind_timer
	var second_wind_time : float = 15.0
	
	
	var second_wind_screen = $CanvasLayer/PC_UI/DeathIsntEndScreen
	var second_wind_vfx = $CanvasLayer/PC_UI/PC_StatusVFX
	#
	#second_timer.wait_time = second_wind_time
	#second_timer.connect('timeout', death)
	#second_timer.start()
	#
	second_wind_screen.visible = true
	second_wind_vfx.visible = true
	
	$CanvasLayer/PC_UI/PC_StatusVFX/ScreenRimA/AnimationPlayer.play('fade')
	$CanvasLayer/PC_UI/DeathIsntEndScreen/AnimationPlayer.play('Pulse')
	
	#if Input.is_action_just_pressed("ui_accept"):
		#$CanvasLayer/PC_UI/DeathIsntEndScreen/TextureProgressBar.value += 10.0
	
	get_tree().paused = true
	
	#is_dying = false
	#sleep_tick()
	print('dying mini game')
	pass
	

func death():
	var MM_P : PackedScene = load("res://K9/Lvls/MM/main_menu.tscn")
	
	get_tree().change_scene_to_packed(MM_P)
	
	print('death')
	
	pass
	

func show_current_task_hint(text_to_display):
	$MarginContainer.visible = true
	$MarginContainer/Label.text = str(text_to_display)
	await get_tree().create_timer(5.0).timeout
	$MarginContainer.visible = false
	pass
