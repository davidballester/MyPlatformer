extends FallingPlatformState
class_name FallingPlatformIdleState

const MIN_ITERATIONS_BEFORE_RETURN_TO_POSITION = 2
const MAX_ITERATIONS_BEFORE_RETURN_TO_POSITION = 5
const DRIFT_MOVEMENT_X = 5

@export var falling_state: State
var starts_with_character: bool
var is_falling: bool
var waiting_to_fall: bool
var drift_tween: Tween
var original_position: Vector2
var iterations_until_return_to_position: int = get_iterations_until_return_to_position()

func enter() -> void:
	falling_platform.play_animation(FallingPlatform.AnimationType.ON)
	original_position = Vector2(falling_platform.position)
	is_falling = false
	waiting_to_fall = false
	starts_with_character = true if falling_platform.character else false
	drift()
	
func exit() -> void:
	stop_drifting()
	
func physics_process(_delta: float) -> State:
	if is_falling:
		return falling_state
	if waiting_to_fall:
		return null
	if not falling_platform.character:
		return null
	if not starts_with_character:
		falling_platform.shake()
	waiting_to_fall = true
	get_tree().create_timer(falling_platform.fall_after_s).timeout.connect(
		func(): is_falling = true
	)
	return null
	
func drift() -> void:
	drift_tween = get_tree().create_tween()
	iterations_until_return_to_position -= 1
	var next_position = get_random_position() if iterations_until_return_to_position > 0 else original_position
	if iterations_until_return_to_position == 0:
		iterations_until_return_to_position = get_iterations_until_return_to_position()
	drift_tween.tween_property(falling_platform, "position", next_position, 0.5)
	drift_tween.finished.connect(func():
		drift_tween.stop()
		drift()
	)
	
func stop_drifting() -> void:
	if not drift_tween:
		return
	drift_tween.stop()
	
func get_random_position() -> Vector2:
	var random_position = Vector2(original_position)
	random_position.x += randf_range(-DRIFT_MOVEMENT_X, DRIFT_MOVEMENT_X)
	random_position.y += randf_range(-DRIFT_MOVEMENT_X, DRIFT_MOVEMENT_X)
	return random_position

func get_iterations_until_return_to_position() -> int:
	return randi_range(
		MIN_ITERATIONS_BEFORE_RETURN_TO_POSITION, 
		MAX_ITERATIONS_BEFORE_RETURN_TO_POSITION
	)
