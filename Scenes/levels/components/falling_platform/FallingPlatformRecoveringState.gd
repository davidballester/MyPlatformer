extends FallingPlatformState
class_name FallingPlatformRecoveringState

@export var idle_state: State

func enter() -> void:
	print("FallingPlatformRecoveringState.enter")
	falling_platform.play_animation(FallingPlatform.AnimationType.ON)
	
func physics_process(delta: float) -> State:
	var y_speed = falling_platform.recovering_speed * delta
	falling_platform.position.y = max(
		falling_platform.initial_position.y, 
		falling_platform.position.y + y_speed
	)
	return idle_state if falling_platform.position.y <= falling_platform.initial_position.y else null
