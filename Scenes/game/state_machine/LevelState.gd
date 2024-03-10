extends GameState
class_name LevelState

@export var main_menu_state: State
@export var pause_menu_state: State
@export var level_container: Node
var level: Level
var pause_menu: PauseMenu

func enter() -> void:
	game.hud = load("res://scenes/levels/components/hud/HUD.tscn").instantiate()
	game.add_child(game.hud)
	if game.saved_level_scene:
		level = game.saved_level_scene
		game.saved_level_scene = null
	else:
		var level_path = "res://scenes/levels/Level" + str(game.level) + ".tscn"
		level = load(level_path).instantiate()
		set_up_character()
		level_container.add_child(level)
		manage_collectibles()
	
func exit() -> void:
	if game.hud:
		game.hud.queue_free()
		game.hud = null
	if game.saved_level_scene == level:
		return
	game.character.ready.disconnect(position_character)
	game.character.ready.disconnect(set_up_camera)
	game.recreate_character()
	level.queue_free()
		
func input(_event) -> State:
	if not Input.is_action_just_pressed("pause"):
		return null
	game.save_level(level)
	return pause_menu_state

func set_up_character() -> void:
	level.character = game.character
	game.character.ready.connect(position_character)
	game.character.ready.connect(set_up_camera)
	
func position_character() -> void:
	var level_background: TextureRect = level.get_node("Background")
	var y = level_background.offset_bottom - game.character.get_height() - 100
	var x = 100
	game.character.position.x = x
	game.character.position.y = y
	game.character.camera.reset_smoothing()
	
func set_up_camera() -> void:
	var camera: Camera2D = game.character.camera
	camera.limit_left = 0
	camera.limit_top = 0
	var level_background: TextureRect = level.get_node("Background")
	camera.limit_right = floori(level_background.offset_right)
	camera.limit_bottom = floori(level_background.offset_bottom)
	
func manage_collectibles() -> void:
	for child in level.get_node("Collectibles").get_children():
		if child is Collectible:
			child.collected.connect(on_collectible_collected)
			
func on_collectible_collected() -> void:
	game.points += 1
	game.hud.set_points(game.points)
