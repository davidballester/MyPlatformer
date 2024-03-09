extends StateMachine
class_name GameStateMachine

@export var game: Game

func _ready() -> void:
	for child in get_children():
		if child is GameState:
			child.game = game
			child.stated_changed.connect(transition_to_state)
	super._ready()
