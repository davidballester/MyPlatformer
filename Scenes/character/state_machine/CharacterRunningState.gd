extends CharacterState
class_name CharacterRunningState

@export var jumping_state: State
@export var falling_state: State
@export var idle_state: State

func enter():
	var direction = character_input.get_running_direction()
	if direction:
		character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
	character.set_animation(Character.AnimationType.RUN)
	character.accelerate_x(1)
	character.emit_dust()
	
func physics_process(delta: float) -> State:
	var direction = character_input.get_running_direction()
	if not direction:
		return idle_state
	character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
	character.accelerate_x(delta)
	character.move_and_slide()
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
