extends Control
class_name ButtonWithSelectorGroup

var buttons: Array = Array()
var current_button_focused_index = -1

func _ready():
	for child in get_children():
		if child is ButtonWithSelector:
			buttons.append(child)
	if buttons.is_empty():
		return
	select_next_button()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("go_up"):
		select_previous_button()
	elif Input.is_action_just_pressed("go_down"):
		select_next_button()
		
func select_next_button() -> void:
	var next_index = (current_button_focused_index + 1) % buttons.size()
	select_button(next_index)
		
func select_previous_button() -> void:
	var next_index = (current_button_focused_index - 1) % buttons.size()
	select_button(next_index)
	
func select_button(next_index: int) -> void:
	if next_index == current_button_focused_index:
		return
	if current_button_focused_index >= 0:
		buttons[current_button_focused_index].blur()
	current_button_focused_index = next_index
	buttons[current_button_focused_index].focus()
	
