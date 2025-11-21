extends Node

@export var ninja: GameInputSecondsNinja

func _ready() -> void:
	while true:
		# Restart action
		await wait(1)
		ninja.start_restart()
		await wait(1)
		ninja.stop_restart()

		# Start moving right
		ninja.start_moving_right()
		await wait(1)
		ninja.stop_moving_right()

		# Start moving left
		ninja.start_moving_left()
		await wait(1)
		ninja.stop_moving_left()

		# Restart action
		await wait(1)
		ninja.start_restart()
		await wait(1)
		ninja.stop_restart()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
