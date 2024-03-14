extends Character
class_name PlayableCharacter

@onready var camera: Camera2D = $Camera
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var jump_component: JumpComponent = $JumpComponent
@onready var running_component: RunningComponent = $RunningComponent

func take_damage() -> void:
	state_machine.take_damage()

func jump() -> void:
	jump_component.jump(extra_jump_velocity)
	
func enter_jump_state() -> void:
	can_double_jump = true
	state_machine.jump()
	
func cut_jump() -> void:
	jump_component.cut_jump()
	
func inertia_y(delta: float) -> void:
	jump_component.inertia(delta)

func accelerate_x(delta: float) -> void:
	running_component.accelerate(delta)
	
func inertia_x() -> void:
	running_component.inertia()
