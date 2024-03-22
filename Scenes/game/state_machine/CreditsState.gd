extends GameState
class_name CreditsState

@export var main_menu_state: State
@export var container: Node
var credits_menu: CreditsMenu

func enter() -> void:
	print("CreditsState.enter")
	credits_menu = load("res://scenes/menus/credits_menu/CreditsMenu.tscn").instantiate()
	credits_menu.back_clicked.connect(on_back_clicked)
	container.add_child.call_deferred(credits_menu)
	
func exit() -> void:
	credits_menu.queue_free()
	
func on_back_clicked() -> void:
	print("CreditsState.on_back_clicked")
	state_changed.emit(main_menu_state)
