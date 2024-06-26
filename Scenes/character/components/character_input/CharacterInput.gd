extends Node
class_name CharacterInput

@onready var input_buffer: InputBuffer = $InputBuffer

func get_running_direction() -> float:
	if not Globals.character_input_enabled:
		return 0.0
	return Input.get_axis("go_left", "go_right")
	
func wants_to_jump() -> bool:
	if not Globals.character_input_enabled:
		return false
	return input_buffer and input_buffer.is_action_buffered("jump")
	
func released_jump() -> bool:
	if not Globals.character_input_enabled:
		return false
	return Input.is_action_just_released("jump")

func wants_to_drop() -> bool:
	if not Globals.character_input_enabled:
		return false
	return input_buffer and input_buffer.is_action_buffered("go_down")
