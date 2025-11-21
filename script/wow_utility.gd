class_name WowUtility
extends Resource

## Converts a 32-bit integer into 4 bytes (little endian)
static func parse_to_bytes_i(value_i32: int) -> PackedByteArray:
	var arr := PackedByteArray()
	arr.resize(4)
	arr.encode_s32(0, value_i32)
	return arr


## Converts two 32-bit integers into 8 bytes (little endian)
static func parse_to_bytes_ii(player_index_i32: int, value_i32: int) -> PackedByteArray:
	var arr := PackedByteArray()
	arr.resize(8)
	arr.encode_s32(0, player_index_i32)
	arr.encode_s32(4, value_i32)
	return arr


## Converts two 32-bit integers and a 64-bit unsigned integer (timestamp) into 16 bytes total (little endian)
static func parse_to_bytes_iid(player_index_i32: int, value_i32: int, date_utc_timestamp_ulong: int) -> PackedByteArray:
	var arr := PackedByteArray()
	arr.resize(16)
	arr.encode_s32(0, player_index_i32)
	arr.encode_s32(4, value_i32)
	arr.encode_u64(8, date_utc_timestamp_ulong)
	return arr
	
## Converts two 32-bit integers and the current UTC timestamp (adjusted by ntp_adjustement_ms)
## into 16 bytes total (little endian)
static func parse_to_bytes_iid_current_time(player_index_i32: int, value_i32: int, ntp_adjustement_ms: int=0) -> PackedByteArray:
	var current_timestamp_ms := Time.get_unix_time_from_system() * 1000  # convert to milliseconds
	current_timestamp_ms += ntp_adjustement_ms  # apply adjustment

	var arr := PackedByteArray()
	arr.resize(16)
	arr.encode_s32(0, player_index_i32)
	arr.encode_s32(4, value_i32)
	arr.encode_u64(8, current_timestamp_ms)
	return arr

static func get_ntp_utc_timestamp_milliseconds(ntp_local_to_server_milliseconds: int) -> int:
	var time = int(Time.get_unix_time_from_system() * 1000.0)
	return time + ntp_local_to_server_milliseconds
