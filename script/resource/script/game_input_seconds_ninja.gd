class_name GameInputSecondsNinja extends Node

signal on_relay_integer_action(action_as_integer:int)


## GameInputSecondsNinja
## Handles input relay for 10 Seconds Ninja game controls
@export_group("Game Input Configuration")
@export var game_input : IntInputResource_10SecondsNinja 

func push_int(action_as_integer:int) -> void:
	emit_signal("on_relay_integer_action", action_as_integer)

func press(value:int):
	push_int(value)

func release(value:int):
	push_int(value + 1000)

func start_moving_left():
	press(game_input.arrow_left)

func stop_moving_left():
	
	release(game_input.arrow_left )

func start_jumping():
	press(game_input.arrow_up_jump)
func stop_jumping():
	release(game_input.arrow_up_jump)

func start_moving_right():
	press(game_input.arrow_right)
func stop_moving_right():
	release(game_input.arrow_right)

func start_arrow_down():
	press(game_input.arrow_down)
func stop_arrow_down():
	release(game_input.arrow_down)

func start_sword_hit():
	press(game_input.key_x_sword)

func stop_sword_hit():
	release(game_input.key_x_sword)

func start_shuriken_hit():
	press(game_input.key_z_shuriken)

func stop_shuriken_hit():
	release(game_input.key_z_shuriken)

func start_option():
	press(game_input.key_c_option)
func stop_option():
	release(game_input.key_c_option)

func start_restart():
	press(game_input.key_r_retry)
	
func stop_restart():
	release(game_input.key_r_retry)

func start_escape():
	press(game_input.key_escape)

func stop_escape():
	release(game_input.key_escape)
