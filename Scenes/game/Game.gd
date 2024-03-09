extends Node
class_name Game

@onready var level_container: Node = $LevelContainer
var level: int = 0
var points: int = 0
var character: Character
var saved_level_scene: Node
var hud: HUD

func create_character(sprite_frames: SpriteFrames) -> void:
	character = load("res://scenes/character/PlayableCharacter.tscn").instantiate()
	character.sprite_frames = sprite_frames
	
func recreate_character() -> void:
	var old_character = character
	create_character(old_character.sprite_frames)
	old_character.queue_free()
	
func save_level(saved_level: Node) -> void:
	print("Game.save_level ", saved_level)
	saved_level_scene = saved_level
	
func pause() -> void:
	level_container.get_tree().paused = true
	
func resume() -> void:
	level_container.get_tree().paused = false
	
func reset() -> void:
	level = 0
	points = 0
	if character:
		character.queue_free()
		character = null
	if saved_level_scene:
		saved_level_scene.queue_free()
		saved_level_scene = null
	if hud:
		hud.queue_free()
		hud = null
