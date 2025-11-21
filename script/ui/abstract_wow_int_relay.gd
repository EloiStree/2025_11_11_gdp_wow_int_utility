class_name AbstractWowIntRelay extends Node

signal on_relayed_integer(value_to_relay:int)


func relay_integer(value_to_relay:int):
	on_relayed_integer.emit(value_to_relay)
	print("Relayed Integer: %d" % value_to_relay)
