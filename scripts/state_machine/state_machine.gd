extends Node
class_name StateMachine

@export var initial_state: State:
	set(state):
		current_state = state
var current_state: State

func _ready():
	if not current_state:
		return
	current_state.enter()

func _process(delta: float) -> void:
	if not current_state:
		pass
	var next_state = current_state.process(delta)
	if next_state:
		transition_to_state(next_state)
		
func _physics_process(delta) -> void:
	if not current_state:
		pass
	var next_state = current_state.physics_process(delta)
	if next_state:
		transition_to_state(next_state)
		
func _input(event: InputEvent) -> void:
	if not current_state:
		pass
	var next_state = current_state.input(event)
	if next_state:
		transition_to_state(next_state)
			
func transition_to_state(state: State) -> void:
	print("StateMachine.transition_to_state ", state)
	if current_state:
		current_state.exit()
	current_state = state
	current_state.enter()
