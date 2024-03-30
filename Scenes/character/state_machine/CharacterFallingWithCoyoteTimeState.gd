extends CharacterFallingState
class_name CharacterFallingWithCoyoteTime

@export var falling_state: State
@export var jump_state: State
var remaining_coyote_time_ms: float

func enter() -> void:
	remaining_coyote_time_ms = character.coyote_time_ms
	character.stop_emitting_dust()
	
func process(delta: float) -> State:
	remaining_coyote_time_ms -= delta
	return falling_state if remaining_coyote_time_ms <= 0 else null

func physics_process(delta):
	var state = super.physics_process(delta)
	if state:
		return state
	if character_input.wants_to_jump():
		return jump_state
