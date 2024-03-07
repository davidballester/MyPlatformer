extends CharacterState
class_name CharacterRunningState

@export var jumping_state: State
@export var falling_state: State
@export var idle_state: State

func enter():
	var direction = Input.get_axis("go_left", "go_right")
	character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
	character.velocity.x = direction * character.speed
	character.set_animation(Character.AnimationType.RUN)
	
func physics_process(_delta: float) -> State:
	var direction = Input.get_axis("go_left", "go_right")
	if not direction:
		return idle_state
	character.direction = Character.Direction.LEFT if direction < 0 else Character.Direction.RIGHT
	character.velocity.x = direction * character.speed
	character.move_and_slide()
	if input_buffer.is_action_buffered("jump"):
		return jumping_state
	if not character.is_on_floor():
		return falling_state
	return null
