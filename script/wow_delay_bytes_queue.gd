class_name WowDelayBytesQueue extends Node

signal on_bytes_to_push(pushed: PackedByteArray)

var delay_bytes_push_list : Array[DelayBytesPush]=[]
var last_checked_time_ms: int = -1
@export var current_queue_size: int = 0


func _process(delta: float) -> void:
	check_for_pack_to_push()

func get_current_utc_time_milliseconds() -> int:
	var time = int(Time.get_unix_time_from_system() * 1000.0)
	return time

func add_delay_by_seconds(given_bytes: PackedByteArray, delay_in_seconds: float) -> void:
	add_delay_by_milliseconds(given_bytes, int(delay_in_seconds * 1000.0))

func add_delay_by_milliseconds(given_bytes: PackedByteArray, delay_in_milliseconds: int) -> void:
	var delay_bytes_push := DelayBytesPush.new()
	delay_bytes_push.bytes_to_push = given_bytes
	delay_bytes_push.execution_time_ms = get_current_utc_time_milliseconds() + delay_in_milliseconds
	delay_bytes_push_list.append(delay_bytes_push)
	current_queue_size = delay_bytes_push_list.size()

func check_for_pack_to_push() -> Array[PackedByteArray]:
	var bytes_to_push_list: Array[PackedByteArray] = []
	var current_time_ms = get_current_utc_time_milliseconds()

	if last_checked_time_ms == -1:
		last_checked_time_ms = current_time_ms

	if current_time_ms > last_checked_time_ms:
		var remove_indices: Array[int] = []
		for i in range(delay_bytes_push_list.size()):
			var delay_bytes_push = delay_bytes_push_list[i]
			if delay_bytes_push.execution_time_ms <= current_time_ms:
				bytes_to_push_list.append(delay_bytes_push.bytes_to_push)
				remove_indices.append(i)

		for j in range(remove_indices.size() - 1, -1, -1):
			delay_bytes_push_list.remove_at(remove_indices[j])

		last_checked_time_ms = current_time_ms

	return bytes_to_push_list

class DelayBytesPush:
	var bytes_to_push: PackedByteArray
	var execution_time_ms: int
