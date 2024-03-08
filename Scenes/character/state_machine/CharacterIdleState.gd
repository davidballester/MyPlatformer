extends CharacterState
class_name CharacterIdleState

@export var jumping_state: State
@export var falling_state: State
@export var running_state: State

func enter() -> void:
	character.set_animation(Character.AnimationType.IDLE)

func physics_process(_delta: float) -> State:
	character.velocity.x = move_toward(character.velocity.x, 0, character.inertia)
	character.move_and_slide()
	var direction = character_input.get_running_direction()
	if direction:
		return running_state
	if character_input.wants_to_jump():
		return jumping_state
	if not character.is_on_floor():
		character.set_coyote_time()
		return falling_state
	return null
