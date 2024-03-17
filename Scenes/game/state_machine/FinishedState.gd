extends GameState
class_name FinishedState

@export var main_menu_state: State
@export var container: Node
var finished_menu: FinishedMenu

func enter() -> void:
	game.pause()
	finished_menu = load("res://scenes/menus/finished_menu/FinishedMenu.tscn").instantiate()
	finished_menu.finished.connect(go_to_main_menu)
	container.add_child(finished_menu)
	
func exit() -> void:
	finished_menu.queue_free()
	game.resume()
	
func go_to_main_menu():
	print("QuitMenuState.go_to_main_menu")
	game.reset()
	state_changed.emit(main_menu_state)