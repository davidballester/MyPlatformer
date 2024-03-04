extends Node

@onready var main_menu: MainMenu = get_node("MainMenu")
@onready var hud: HUD = get_node("HUD")
@onready var level_container: Node = get_node("LevelContainer")

func _ready():
	main_menu.started.connect(on_started)
	
func on_started(sprite_frames: SpriteFrames):
	print("Game.on_character_selected ", sprite_frames)
	load_level(1, sprite_frames)
	hud.visible = true
	main_menu.visible = false

func load_level(level: int, character_sprite_frames: SpriteFrames):
	var level_path = "res://scenes/levels/Level" + str(level) + ".tscn"
	print("Game.load_level ", level_path)
	var level_scene = load(level_path).instantiate()
	set_up_character(character_sprite_frames, level_scene)
	var existing_level: Level = level_container.get_node_or_null("Level")
	if existing_level:
		existing_level.queue_free()
	level_container.add_child(level_scene)
	
func set_up_character(character_sprite_frames: SpriteFrames, level: Level):
	var character: Character = load("res://scenes/Character.tscn").instantiate()
	character.sprite_frames = character_sprite_frames
	level.add_child(character)
	character.ready.connect(position_character.bind(character, level))
	character.ready.connect(add_camera.bind(character))
	return character

func position_character(character: Character, level: Level):
	var level_background: TextureRect = level.get_node("Background")
	var y = level_background.offset_bottom - character.get_height() - 100
	var x = 100
	print("Game.position_character x=", x, " y=", y)
	character.position.x = x
	character.position.y = y
	
func add_camera(character: Character):
	var camera: Camera2D = load("res://scenes/level_components/Camera.tscn").instantiate()
	character.add_child(camera)
