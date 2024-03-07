extends FireTrapState
class_name FireTrapIdleState

@export var active_state: State
var is_idle: bool

func enter() -> void:
	is_idle = true
	fire_trap.set_animation(FireTrap.AnimationType.IDLE)
	var timer = get_tree().create_timer(fire_trap.idle_time_s)
	timer.timeout.connect(activate)
	
func process(_delta: float) -> State:
	return null if is_idle else active_state
	
func activate() -> void:
	is_idle = false
