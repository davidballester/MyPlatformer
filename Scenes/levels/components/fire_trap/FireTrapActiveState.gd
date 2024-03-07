extends FireTrapState
class_name FireTrapActiveState

@export var idle_state: State
var is_active: bool

func enter() -> void:
	is_active = true
	fire_trap.set_animation(FireTrap.AnimationType.ACTIVE)
	var timer = get_tree().create_timer(fire_trap.active_time_s)
	timer.timeout.connect(deactivate)
	
func process(_delta: float) -> State:
	if character:
		character.take_damage()
	return null if is_active else idle_state
	
func deactivate() -> void:
	is_active = false
	

