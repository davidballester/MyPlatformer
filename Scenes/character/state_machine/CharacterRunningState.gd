extends CharacterState
class_name CharacterRunningState

@export var jumping_state: State
@export var falling_state: State
@export var idle_state: State

func enter():
	var direction = character_input.get_running_direction()
	character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
	character.velocity.x = direction * character.speed
	character.set_animation(Character.AnimationType.RUN)
	
func physics_process(_delta: float) -> State:
	var direction = character_input.get_running_direction()
	if not direction:
		return idle_state
	character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
	character.velocity.x = direction * character.speed
	character.move_and_slide()
	if character_input.wants_to_jump():
		character.can_double_jump = true
		return jumping_state
	if not character.is_on_floor():
		character.set_coyote_time(true)
		character.can_double_jump = true
		return falling_state
	return null
