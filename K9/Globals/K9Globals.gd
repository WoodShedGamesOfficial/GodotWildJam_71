extends Node

var player_pos : Vector2

var player_sleep: float

var level_path_to_load: PackedScene

var tick_time : float = 2.5

var lives_left_to_sleep_away : int = 3

#var key_list = {
	##append keys
#}

var game_stage : int = 0

var current_task : String

var calendar_date : int = 1

var dialogue_wait_time : float = 5.0
