extends CharacterState
class_name CharacterFallingState

@export var idle_state: State
@export var jumping_state: State
@export var running_state: State

func enter() -> void:
	character.set_animation(Character.AnimationType.FALL)
	character.velocity.y = 0
	character.stop_emitting_running_dust()
	
func process(_delta: float) -> State:
	if not character_input.wants_to_jump() or not character.can_double_jump:
		return
	return jumping_state
	
func physics_process(delta: float) -> State:
	character.inertia_y(delta)
	var direction = character_input.get_running_direction()
	if direction:
		character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
		character.accelerate_x(delta)
	character.move_and_slide()
	if character.is_on_floor():
		character.emit_landing_dust()
		return running_state if direction else idle_state
	if character_input.wants_to_jump():
		if character.on_coyote_time:
			character.can_double_jump = true
			return jumping_state
		if character.can_double_jump:
			character.can_double_jump = false
			return jumping_state
	return null
