extends StateMachine
class_name CharacterStateMachine

@export var character: Character
@export var character_input: CharacterInput
@onready var hurt_state: CharacterHurtState = $CharacterHurtState
@onready var jumping_state: CharacterJumpingState = $CharacterJumpingState

func _ready():
	for state in get_children():
		if state is CharacterState:
			print("CharacterStateMachine._ready ", state)
			state.character = character
			state.character_input = character_input

func take_damage() -> void:
	if not hurt_state or current_state == hurt_state:
		return
	transition_to_state(hurt_state)

func trampoline() -> void:
	if current_state == hurt_state:
		return
	character.on_trampoline = true
	character.can_double_jump = true
	transition_to_state(jumping_state)
		
