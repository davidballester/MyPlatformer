extends CharacterState
class_name CharacterJumpingState

@export var falling_state: State

func enter() -> void:
	if character.can_double_jump:
		character.set_animation(Character.AnimationType.JUMP)
	else:
		character.set_animation(Character.AnimationType.DOUBLE_JUMP)
	character.velocity.y = character.jump_velocity if not character.on_trampoline else character.trampoline_velocity
	character.on_trampoline = false
	character.set_coyote_time(false)
	
func physics_process(delta: float) -> State:
	character.velocity.y += character.gravity * delta
	if character.velocity.y > 0:
		return falling_state
	var direction = character_input.get_running_direction()
	if direction:
		character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
		character.velocity.x = direction * character.speed
	if character_input.wants_to_jump() and character.can_double_jump:
		character.can_double_jump = false
		return self
	character.move_and_slide()
	return null
