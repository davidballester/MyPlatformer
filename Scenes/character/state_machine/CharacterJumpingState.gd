extends CharacterState
class_name CharacterJumpingState

@export var falling_state: State

func enter() -> void:
	character.set_animation(Character.AnimationType.JUMP)
	character.velocity.y = character.jump_velocity

func physics_process(delta: float) -> State:
	character.velocity.y += character.gravity * delta
	if character.velocity.y > 0:
		return falling_state
	var direction = character_input.get_running_direction()
	if direction:
		character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
		character.velocity.x = direction * character.speed
	character.move_and_slide()
	return null
