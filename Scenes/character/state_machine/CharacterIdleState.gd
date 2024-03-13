extends CharacterState
class_name CharacterIdleState

@export var jumping_state: State
@export var falling_state: State
@export var running_state: State

func enter() -> void:
	character.set_animation(Character.AnimationType.IDLE)

func physics_process(_delta: float) -> State:
	character.inertia_x()
	character.move_and_slide()
	var direction = character_input.get_running_direction()
	if direction:
		return running_state
	if character_input.wants_to_jump():
		character.can_double_jump = true
		return jumping_state
	if character_input.wants_to_drop():
		var can_drop = character.drop()
		if can_drop:
			return fall()
	if not character.is_on_floor():
		return fall()
	return null

func fall() -> State:
	character.set_coyote_time(true)
	character.can_double_jump = true
	return falling_state
