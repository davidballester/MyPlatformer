extends Object
class_name InputActionBuffer

var buffer: Array = Array()

func add_input_action(input_action: InputAction):
	buffer.append(input_action)
	
func update_fresh_period_ms(delta_ms: float):
	for input_action: InputAction in buffer:
		input_action.fresh_period_ms -= delta_ms
		
func get_input_action():
	while not buffer.is_empty():
		var input_action: InputAction = buffer.pop_front()
		if input_action.is_fresh():
			return input_action
		
	
