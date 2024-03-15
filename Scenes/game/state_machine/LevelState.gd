extends GameState
class_name LevelState

@export var main_menu_state: State
@export var pause_menu_state: State
@export var level_container: Node
var level: Level
var pause_menu: PauseMenu

func enter() -> void:
	if game.saved_level_scene:
		level = game.saved_level_scene
		level.show_hud()
		game.saved_level_scene = null
	else:
		var level_path = "res://scenes/levels/Level" + str(game.level) + ".tscn"
		level = load(level_path).instantiate()
		level.collectibles_collected = game.collectibles_carried_over
		game.collectibles_carried_over = 0
		level_container.add_child(level)
		level.character.sprite_frames = game.character_sprite
		set_up_camera()
		manage_collectibles()

func exit() -> void:
	if game.saved_level_scene == level:
		level.hide_hud()
		return
	game.collectibles_carried_over = level.collectibles_collected - level.collectibles_required
	level.queue_free()
		
func input(_event) -> State:
	if not Input.is_action_just_pressed("pause"):
		return null
	game.save_level(level)
	return pause_menu_state
	
func set_up_camera() -> void:
	var camera: Camera2D = level.character.camera
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
	level.collectibles_collected += 1
	level.hud.update()
