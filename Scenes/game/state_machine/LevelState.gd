extends GameState
class_name LevelState

@export var main_menu_state: State
@export var pause_menu_state: State
@export var level_state: State
@export var finished_state: FinishedState
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
		if not FileAccess.file_exists(level_path):
			state_changed.emit(finished_state)
			return
		level = load(level_path).instantiate()
		level.collectibles_collected = game.collectibles_carried_over
		game.collectibles_carried_over = 0
		level_container.add_child(level)
		level.character.sprite_frames = game.character_sprite
		manage_collectibles()
		level.exit.entered.connect(on_exit_entered)
		set_up_camera()
		do_camera_traveling()

func exit() -> void:
	if game.saved_level_scene == level:
		level.hide_hud()
		return
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

func on_exit_entered() -> void:
	if not level.can_exit():
		return
	Globals.character_input_enabled = false
	await level.exit.play()
	var collectibles_carried_over = level.collectibles_collected - level.collectibles_required
	game.next_level(collectibles_carried_over)
	state_changed.emit(level_state)
	Globals.character_input_enabled = true

func do_camera_traveling() -> void:
	var camera_travelling: CameraTravelling = level.get_node("CameraTravellingContainer/CameraTravelling")
	camera_travelling.camera = level.character.camera
	Globals.character_input_enabled = false
	camera_travelling.start()
	await camera_travelling.finished
	Globals.character_input_enabled = true
	
