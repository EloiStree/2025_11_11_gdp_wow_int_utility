class_name WowIntToBytesPusher
extends Node

signal on_bytes_to_push(pushed: PackedByteArray)

@export var bytes_delayer:WowDelayBytesQueue
@export var ntp_local_to_server_milliseconds: int = 0
@export var default_player_claim_index: int = 0

@export_group("Debug")
@export var bytes_sent: int 
@export var as_text_sent: String 
@export var as_bytes_sent: PackedByteArray 


func _process(delta: float) -> void:
	var bytes_to_push_list: Array[PackedByteArray] = bytes_delayer.check_for_pack_to_push()
	for bytes_to_push in bytes_to_push_list:
		push_bytes(bytes_to_push)

# --------------------------------------------
# Main push methods
# --------------------------------------------
func push_bytes(bytes_to_push: PackedByteArray) -> void:
	if bytes_to_push != null and bytes_to_push.size() > 0:
		on_bytes_to_push.emit(bytes_to_push)
		bytes_sent += bytes_to_push.size()
		as_bytes_sent = bytes_to_push

func debug_text(text :String):
	as_text_sent = text

func get_ntp_utc_timestamp_milliseconds() -> int:
	var time = int(Time.get_unix_time_from_system() * 1000.0)
	return time + ntp_local_to_server_milliseconds

func push_integer_value(integer_value: int) -> void:
	var bytes = WowUtility.parse_to_bytes_iid_current_time(
		default_player_claim_index,
		integer_value,
		get_ntp_utc_timestamp_milliseconds()
	)
	push_bytes(bytes)
	debug_text("i:" + str(integer_value))
	

func push_player_index_and_value(player_index: int, integer_value: int) -> void:
	var bytes = WowUtility.parse_to_bytes_iid_current_time(
		player_index,
		integer_value,
		get_ntp_utc_timestamp_milliseconds()
	)
	push_bytes(bytes)	
	debug_text("pi:" + str(player_index) + " Vi:" + str(integer_value))

func push_integer_value_with_execute_time(integer_value: int, date_timestamp_utc: int) -> void:
	var bytes = WowUtility.parse_to_bytes_iid(
		default_player_claim_index,
		integer_value,
		date_timestamp_utc
	)
	push_bytes(bytes)
	debug_text("i:" + str(integer_value)+" ts:" + str(date_timestamp_utc))

func push_player_index_and_value_with_execute_time(player_index: int, integer_value: int, date_timestamp_utc: int) -> void:
	var bytes = WowUtility.parse_to_bytes_iid(
		player_index,
		integer_value,
		date_timestamp_utc
	)
	push_bytes(bytes)
	debug_text("pi:" + str(player_index) + " Vi:" + str(integer_value)+" ts:" + str(date_timestamp_utc))

func push_with_local_delay_integer_value_in_milliseconds(integer_value: int, milliseconds_delay: int) -> void:
	var bytes = WowUtility.parse_to_bytes_iid_current_time(
		default_player_claim_index,
		integer_value,
		get_ntp_utc_timestamp_milliseconds() + milliseconds_delay
	)
	bytes_delayer.add_delay_by_milliseconds(bytes, milliseconds_delay)
	debug_text("i:" + str(integer_value)+" delay:" + str(milliseconds_delay))
	

# NOTE: Renamed this one to avoid duplicate function name
func push_with_local_delay_player_index_and_integer_value_in_milliseconds(player_index: int, integer_value: int, milliseconds_delay: int) -> void:
	var bytes = WowUtility.parse_to_bytes_iid_current_time(
		player_index,
		integer_value,
		get_ntp_utc_timestamp_milliseconds() + milliseconds_delay
	)
	bytes_delayer.add_delay_by_milliseconds(bytes, milliseconds_delay)
	debug_text("pi:" + str(player_index) + " Vi:" + str(integer_value)+" delay:" + str(milliseconds_delay))

func push_with_local_delay_integer_value_in_seconds(integer_value: int, seconds_delay: float) -> void:
	var milliseconds_delay: int = int(seconds_delay * 1000.0)
	var bytes = WowUtility.parse_to_bytes_iid_current_time(
		default_player_claim_index,
		integer_value,
		get_ntp_utc_timestamp_milliseconds() + milliseconds_delay
	)
	bytes_delayer.add_delay_by_milliseconds(bytes, milliseconds_delay)
	debug_text("i:" + str(integer_value)+" delay:" + str(milliseconds_delay))

func push_with_local_delay_player_index_and_integer_value_in_seconds(player_index: int, integer_value: int, seconds_delay: float) -> void:
	var milliseconds_delay: int = int(seconds_delay * 1000.0)
	var bytes = WowUtility.parse_to_bytes_iid_current_time(
		player_index,
		integer_value,
		get_ntp_utc_timestamp_milliseconds() + milliseconds_delay
	)
	bytes_delayer.add_delay_by_milliseconds(bytes, milliseconds_delay)
	debug_text("pi:" + str(player_index) + " Vi:" + str(integer_value)+" delay:" + str(milliseconds_delay))
