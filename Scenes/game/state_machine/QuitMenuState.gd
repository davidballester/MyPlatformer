extends GameState
class_name QuitMenuState

@export var pause_menu_state: State
@export var main_menu_state: State
@export var container: Node
var quit_menu: QuitMenu

func enter() -> void:
	game.pause()
	quit_menu = load("res://scenes/menus/quit_menu/QuitMenu.tscn").instantiate()
	quit_menu.yes_clicked.connect(go_to_main_menu)
	quit_menu.no_clicked.connect(go_to_pause_menu)
	container.add_child(quit_menu)
	
func exit() -> void:
	quit_menu.queue_free()
	
func input(_event: InputEvent) -> State:
	if not Input.is_action_just_pressed("pause"):
		return
	go_to_pause_menu()
	return null
	
func go_to_pause_menu():
	state_changed.emit(pause_menu_state)

func go_to_main_menu():
	game.reset()
	state_changed.emit(main_menu_state)
	game.resume()
