extends CharacterState
class_name CharacterHurtState

@export var running_state: State

func enter() -> void:
	match character.direction:
		Character.Direction.LEFT:
			character.direction = Character.Direction.RIGHT
		Character.Direction.RIGHT:
			character.direction = Character.Direction.LEFT
	character.jump()
	character.set_animation(Character.AnimationType.HURT)
	character.stop_emitting_dust()
	
func physics_process(delta: float) -> State:
	character.inertia_y(delta)
	if character.velocity.y > 0:
		character.set_animation(Character.AnimationType.FALL)
	character.accelerate_x(delta)
	character.move_and_slide()
	return running_state if character.is_on_floor() else null
