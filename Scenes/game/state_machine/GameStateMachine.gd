extends StateMachine
class_name GameStateMachine

@export var game: Game
@export var scene_transition: SceneTransition

func _ready() -> void:
	for child in get_children():
		if child is GameState:
			child.game = game
			child.state_changed.connect(transition_to_state)
	super._ready()

func transition_to_state(state: State) -> void:
	var is_transition_between_levels = current_state is LevelState and state is LevelState
	var should_use_transition = current_state is MainMenuState or is_transition_between_levels
	if should_use_transition:
		await scene_transition.roll_in()
	super.transition_to_state(state)
	if should_use_transition:
		await scene_transition.roll_out()
