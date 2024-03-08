extends StateMachine
class_name CharacterStateMachine

@export var character: Character
@onready var input_buffer: InputBuffer = $InputBuffer
@onready var hurt_state: CharacterHurtState = $CharacterHurtState

func _ready():
	print("CharacterStateMachine._ready ", character, " ", input_buffer)
	for state in get_children():
		if state is CharacterState:
			print("CharacterStateMachine._ready ", state)
			state.character = character
			state.input_buffer = input_buffer

func take_damage() -> void:
	if not hurt_state or current_state == hurt_state:
		return
	transition_to_state(hurt_state)
