extends GameState
class_name LevelState

var hud: HUD
var level_container: Node
var level: Level

func enter() -> void:
	hud = load("res://scenes/levels/HUD.tscn").instantiate()
	hud.offset.x = 25
	hud.offset.y = 25
	game.add_child(hud)
	level_container = Node.new()
	game.add_child(level_container)
	var level_path = "res://scenes/levels/Level" + str(game.level) + ".tscn"
	level = load(level_path).instantiate()
	set_up_character()
	var existing_level: Level = level_container.get_node_or_null("Level")
	if existing_level:
		existing_level.queue_free()
	level_container.add_child(level)
	manage_collectibles()
	
func exit() -> void:
	game.character.eady.disconnect(position_character)
	game.character.eady.disconnect(set_up_camera)
		
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
	hud.set_points(game.points)
