extends GameState
class_name MainMenuState

@export var level_state: State
var main_menu: MainMenu

func enter() -> void:
	print("MainMenuState.enter")
	main_menu = load("res://scenes/main_menu/MainMenu.tscn").instantiate()
	main_menu.started.connect(on_started)
	game.add_child.call_deferred(main_menu)
	
func exit() -> void:
	main_menu.queue_free()
	
func on_started(sprite_frames: SpriteFrames) -> void:
	print("MainMenuState.on_started")
	game.create_character(sprite_frames)
	game.level = 1
	stated_changed.emit(level_state)
