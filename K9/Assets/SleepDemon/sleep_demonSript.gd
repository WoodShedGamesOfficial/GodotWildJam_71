extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.

@onready var detection_area = $DetectionArea
#@onready var 
@onready var player = get_tree().current_scene.get_node_or_null('PC')

var target_pos : Vector2 = K9Globals.player_pos
var is_in_range : bool


func _ready():
	$AnimatedSprite2D.play("Walk")
	detection_area.connect("body_entered", check)
	detection_area.connect("body_exited", e_check)
	pass
	

func _physics_process(delta):
	# Add the gravity.
	
	if is_in_range == true:
		velocity = (position.direction_to(target_pos) * SPEED)
		K9Globals.player_sleep -= 0.05
		#print('player_sleep' + str(K9Globals.player_sleep))
	#else:
		#velocity = Vector2(0, 0)
	
	move_and_slide()
	pass
	

func _process(delta):
	
	target_pos = K9Globals.player_pos
	

	#else: 
		#velocity = Vector2(0, 0)
	
	pass

func check(body):
	
	if body.is_in_group('player'):
		#body.drain_sleep()
		is_in_range = true
		#K9Globals.player_sleep -= 0.002
	
	
	
	#print('player position' + str(body.position))
	pass
	

func e_check(body):
	if body.is_in_group('player'):
		is_in_range = false
		velocity = Vector2(0,0)
	pass
