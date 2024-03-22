extends GameState
class_name MainMenuState

@export var level_state: State
@export var credits_state: State
@export var container: Node
var main_menu: MainMenu

func enter() -> void:
	print("MainMenuState.enter")
	main_menu = load("res://scenes/menus/main_menu/MainMenu.tscn").instantiate()
	main_menu.started.connect(on_started)
	main_menu.credits_clicked.connect(on_credits_clicked)
	container.add_child.call_deferred(main_menu)
	
func exit() -> void:
	main_menu.queue_free()
	
func on_started(sprite_frames: SpriteFrames) -> void:
	print("MainMenuState.on_started")
	game.set_character_sprite(sprite_frames)
	game.level = 1
	state_changed.emit(level_state)

func on_credits_clicked() -> void:
	print("MainMenuState.on_credits_clicked")
	state_changed.emit(credits_state)
