extends GameState
class_name PauseMenuState

@export var level_state: State
@export var main_menu_state: State
@export var container: Node
var pause_menu: PauseMenu

func enter() -> void:
	game.pause()
	pause_menu = load("res://scenes/menus/pause_menu/PauseMenu.tscn").instantiate()
	pause_menu.resume_clicked.connect(resume)
	pause_menu.exit_clicked.connect(go_to_main_menu)
	container.add_child(pause_menu)
	
func input(_event: InputEvent) -> State:
	if not Input.is_action_just_pressed("pause"):
		return
	resume()
	return null
	
func resume():
	print("PauseMenuState.resume")
	pause_menu.queue_free()
	game.resume()
	state_changed.emit(level_state)

func go_to_main_menu():
	print("PauseMenuState.go_to_main_menu")
	game.reset()
	pause_menu.queue_free()
	state_changed.emit(main_menu_state)
	game.resume()
