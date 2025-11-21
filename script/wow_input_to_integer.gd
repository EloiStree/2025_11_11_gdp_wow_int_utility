# WowInputToInteger.gd
class_name WowInputToInteger
extends Node

signal on_integer_input(integer_value: int)

## Dictionary mapping input action names to integer values
@export_multiline var input_to_integer_press_release: String = """
Space|1024|2024
Escape|1027|2027
Space|1032|2032
PageUp|1033|2033
PageDown|1034|2034
End|1035|2035
Home|1036|2036
Left|1037|2037
Up|1038|2038
Right|1039|2039
Down|1040|2040
"""

@export var text_to_press_integer: Dictionary = {}
@export var text_to_release_integer: Dictionary = {}


@export var input_name_last: String = ""
@export var input_history_size: int = 10

@export var use_print: bool = true

func _parse_input_mappings() -> void:
	var lines: Array = input_to_integer_press_release.strip_edges(true, true).split("\n")
	for line in lines:
		var parts: Array = line.split("|")
		if parts.size() == 3:
			var action_name: String = parts[0].strip_edges(true, true)
			var press_value: int = int(parts[1].strip_edges(true, true))
			var release_value: int = int(parts[2].strip_edges(true, true))
			text_to_press_integer[action_name] = press_value
			text_to_release_integer[action_name] = release_value

func _ready() -> void:
	_parse_input_mappings()


func _input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	
	if use_print:
		print("Last Input: %s" % input_name_last)
		
	var key_event := event as InputEventKey
	var action_name: String = OS.get_keycode_string(key_event.keycode)
	
	if key_event.pressed and not key_event.echo:
		if action_name in text_to_press_integer:
			var int_value: int = text_to_press_integer[action_name]
			on_integer_input.emit(int_value)
			if use_print:
				print("Pressed Action: %s => Integer: %d" % [action_name, int_value])
	elif not key_event.pressed:
		if action_name in text_to_release_integer:
			var int_value: int = text_to_release_integer[action_name]
			on_integer_input.emit(int_value)
			if use_print:
				print("Released Action: %s => Integer: %d" % [action_name, int_value])
	
	input_name_last = action_name
	
