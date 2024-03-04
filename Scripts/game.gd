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
	var character = create_character(character_sprite_frames)
	level_scene.add_child(character)
	var existing_level: Level = level_container.get_node_or_null("Level")
	if existing_level:
		existing_level.queue_free()
	level_container.add_child(level_scene)
	
func create_character(character_sprite_frames: SpriteFrames):
	var character: Character = load("res://scenes/Character.tscn").instantiate()
	character.sprite_frames = character_sprite_frames
	return character
