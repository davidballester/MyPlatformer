extends GameState
class_name MainMenuState

@export var level_state: State
@export var credits_state: State
@export var container: Node
var main_menu: MainMenu

func enter() -> void:
	main_menu = load("res://scenes/menus/main_menu/MainMenu.tscn").instantiate()
	main_menu.started.connect(on_started)
	main_menu.credits_clicked.connect(on_credits_clicked)
	container.add_child.call_deferred(main_menu)
	
func exit() -> void:
	main_menu.queue_free()
	
func on_started(sprite_frames: SpriteFrames) -> void:
	game.start(sprite_frames)
	state_changed.emit(level_state)

func on_credits_clicked() -> void:
	state_changed.emit(credits_state)
