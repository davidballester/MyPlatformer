extends FallingPlatformState
class_name FallingPlatformIdleState

@export var falling_state: State
var starts_with_character: bool
var is_falling: bool
var waiting_to_fall: bool

func enter() -> void:
	falling_platform.play_animation(FallingPlatform.AnimationType.ON)
	is_falling = false
	waiting_to_fall = false
	starts_with_character = falling_platform.has_character
	
func physics_process(_delta: float) -> State:
	if is_falling:
		return falling_state
	if waiting_to_fall:
		return null
	if not falling_platform.has_character:
		return null
	if not starts_with_character:
		falling_platform.shake()
	waiting_to_fall = true
	get_tree().create_timer(falling_platform.fall_after_s).timeout.connect(
		func(): is_falling = true
	)
	return null
	
