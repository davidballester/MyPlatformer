extends Node
class_name Game

var level: int = 0
var points: int = 0
var character: Character

func create_character(sprite_frames: SpriteFrames) -> void:
	character = load("res://scenes/character/PlayableCharacter.tscn").instantiate()
	character.sprite_frames = sprite_frames

