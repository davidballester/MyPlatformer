extends CharacterState
class_name CharacterHurtState

@export var running_state: State

func enter() -> void:
	match character.direction:
		Character.Direction.LEFT:
			character.direction = Character.Direction.RIGHT
			character.velocity.x = character.speed
		Character.Direction.RIGHT:
			character.direction = Character.Direction.LEFT
			character.velocity.x = -character.speed
	character.velocity.y = character.jump_velocity
	character.set_animation(Character.AnimationType.HURT)
	
func physics_process(delta: float) -> State:
	character.velocity.y += character.gravity * delta
	if character.velocity.y > 0:
		character.set_animation(Character.AnimationType.FALL)
	character.move_and_slide()
	return running_state if character.is_on_floor() else null
