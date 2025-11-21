class_name WowBytesToSingleUdp extends Node


signal on_bytes_sent(sent: PackedByteArray)
signal on_ip_changed(new_ip: String)
signal on_port_changed(new_port: int)


@export var target_ip: String = "127.0.0.1" # default to broadcast
@export var target_port: int = 3615
@export_group("Debug")
@export var bytes_sent: int
@export var last_local_time_sent_ms: int
@export var is_platform_compatible: bool = true

var udp := PacketPeerUDP.new()

func _ready():
	var platform := OS.get_name()
	if platform in ["HTML5", "Web"]:
		push_warning("WowBytesToSingleUdp: UDP broadcast is not supported on platform '%s'." % platform)
		is_platform_compatible = false
		return
	udp.set_broadcast_enabled(true)
	udp.set_dest_address(target_ip, target_port)

func set_target_address(ip: String, port: int):
	target_ip = ip
	target_port = port
	udp.set_dest_address(target_ip, target_port)
	emit_signal("on_ip_changed", target_ip)
	emit_signal("on_port_changed", target_port)

func set_target_ip(ip: String):
	target_ip = ip
	udp.set_dest_address(target_ip, target_port)
	emit_signal("on_ip_changed", target_ip)

func set_target_port(port: int):
	target_port = port
	udp.set_dest_address(target_ip, target_port)

	emit_signal("on_port_changed", target_port)

func is_platform_supported() -> bool:
	return is_platform_compatible

func get_bytes_sent() -> int:
	return bytes_sent

func push_bytes(bytes_to_send: PackedByteArray):
	var platform := OS.get_name()
	if platform in ["HTML5", "Web"]:
		push_warning("UDP broadcast not supported on '%s'." % platform)
		return

	if bytes_to_send.is_empty():
		return

	var send_result = udp.put_packet(bytes_to_send)
	if send_result != OK:
		push_error("UDP broadcast send failed: %s" % [send_result])
	else:
		last_local_time_sent_ms = int(Time.get_unix_time_from_system() * 1000.0)
		bytes_sent += bytes_to_send.size()
		on_bytes_sent.emit(bytes_to_send)


func _on_wow_int_to_bytes_pusher_on_bytes_to_push(pushed: PackedByteArray) -> void:
	pass # Replace with function body.
