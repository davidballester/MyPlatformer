extends Node

@onready var main_menu: MainMenu = get_node("MainMenu")
var level: int = 0
var character_sprite_frames: SpriteFrames

func _ready():
	main_menu.started.connect(on_started)
	
func on_started(sprite_frames: SpriteFrames):
	print("Game.on_character_selected", sprite_frames)
	character_sprite_frames = sprite_frames

