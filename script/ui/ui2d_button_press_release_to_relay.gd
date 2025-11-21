
class_name Ui2DButtonPressReleaseToRelay extends Node


@export var parent_button_to_listen :Button
@export var to_relay_at:AbstractWowIntRelay
@export var description:String = "Jump"
@export var press_integer:int = 1032
@export var release_integer:int = 2032

func _on_button_pressed() -> void:
    print("Button Pressed: %s" % description)
    if to_relay_at:
        to_relay_at.relay_integer(press_integer)

func _on_button_released() -> void:
    print("Button Released: %s" % description)
    if to_relay_at:
        to_relay_at.relay_integer(release_integer)


func set_relay_target(new_relay_target:AbstractWowIntRelay) -> void:
    to_relay_at = new_relay_target
    

func _ready() -> void:

    if not parent_button_to_listen:
        parent_button_to_listen = get_parent() as Button
        if not parent_button_to_listen:
            parent_button_to_listen = get_node_or_null("Button") as Button
            if not parent_button_to_listen:
                parent_button_to_listen = get_node_or_null("../Button") as Button
    parent_button_to_listen.button_up.connect(_on_button_released)
    parent_button_to_listen.button_down.connect(_on_button_pressed)
    print("Ui2DButtonPressReleaseToRelay ready. Listening to button: %s" % parent_button_to_listen.name)
