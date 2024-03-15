extends Node
class_name Game

@onready var level_container: Node = $LevelContainer
var level: int = 0
var collectibles_carried_over: int = 0
var character_sprite: SpriteFrames
var saved_level_scene: Node

func set_character_sprite(sprite_frames: SpriteFrames) -> void:
	character_sprite = sprite_frames
	
func save_level(saved_level: Node) -> void:
	print("Game.save_level ", saved_level)
	saved_level_scene = saved_level
	
func pause() -> void:
	level_container.get_tree().paused = true
	
func resume() -> void:
	level_container.get_tree().paused = false
	
func reset() -> void:
	level = 0
	collectibles_carried_over = 0
	if saved_level_scene:
		saved_level_scene.queue_free()
		saved_level_scene = null
		
func next_level(new_collectibles_carried_over) -> void:
	level += 1
	collectibles_carried_over = new_collectibles_carried_over
