extends CharacterState
class_name CharacterFallingState

@export var idle_state: State
@export var jump_state: State
@export var running_state: State

func enter() -> void:
	character.set_animation(Character.AnimationType.FALL)
	character.velocity.y = 0
	
func physics_process(delta: float) -> State:
	character.velocity.y += character.gravity * 1.5 * delta
	var direction = character_input.get_running_direction()
	if direction:
		character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
		character.velocity.x = direction * character.speed
	character.move_and_slide()
	if character.is_on_floor():
		return running_state if direction else idle_state
	if character.on_coyote_time and character_input.wants_to_jump():
		return jump_state
	return null
