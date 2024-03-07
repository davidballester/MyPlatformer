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
	var direction = Input.get_axis("go_left", "go_right")
	if direction:
		return running_state
	if input_buffer.is_action_buffered("jump"):
		return jumping_state
	if not character.is_on_floor():
		return falling_state
	return null
