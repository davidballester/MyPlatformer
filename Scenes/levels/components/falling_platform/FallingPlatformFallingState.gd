extends FallingPlatformState
class_name FallingPlatformFallingState

@export var recovering_state: State
var is_recovering: bool = false
var has_collided: bool = false

func enter() -> void:
	is_recovering = false
	has_collided = false
	falling_platform.play_animation(FallingPlatform.AnimationType.OFF)
	falling_platform.initial_position = Vector2(falling_platform.position)

func physics_process(delta: float) -> State:
	if is_recovering:
		return recovering_state
	if has_collided:
		return
	var y_speed = falling_platform.falling_speed * delta
	var collision = falling_platform.move_and_collide(Vector2(0, y_speed))
	if collision:
		get_tree().create_timer(falling_platform.recovering_delay_s).timeout.connect(
			func(): is_recovering = true
		)
		has_collided = true
	return null
