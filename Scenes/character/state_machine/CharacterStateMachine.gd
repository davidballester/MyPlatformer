extends StateMachine
class_name CharacterStateMachine

@export var character: Character
@onready var input_buffer: InputBuffer = $InputBuffer

func _ready():
	print("CharacterStateMachine._ready ", character, " ", input_buffer)
	for state in get_children():
		if state is CharacterState:
			print("CharacterStateMachine._ready ", state)
			state.character = character
			state.input_buffer = input_buffer
