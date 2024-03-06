# Based on https://github.com/drkitt/godot-input-buffer/blob/de66828d3f8a2e190c8f937eb19bc564c28655cc/Input%20buffer/input_buffer.gd

extends Node
class_name InputBuffer

@export var action_to_grace_period_ms: Dictionary = {}
var action_timestamps: Dictionary = {}

func _input(event: InputEvent):
	if not event is InputEventKey or !event.pressed or event.is_echo():
		return
	var action = get_action(event)
	if not action:
		return
	action_timestamps[action] = Time.get_ticks_msec()
	
func is_action_buffered(action: String):
	if not action_timestamps.has(action) or not action_to_grace_period_ms.has(action):
		return false
	var grace_period = action_to_grace_period_ms[action]
	var now = Time.get_ticks_msec()
	var timestamp = action_timestamps[action]
	if now - timestamp > grace_period:
		return false
	action_timestamps[action] = 0
	return true
	
func get_action(event: InputEvent):
	for action in action_to_grace_period_ms.keys():
		var is_action = InputMap.event_is_action(event, action)
		if is_action:
			return action
