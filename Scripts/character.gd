extends Node2D
class_name Character

@export var sprite_frames: SpriteFrames
@onready var animated_sprite2d: AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready():
	animated_sprite2d.sprite_frames = sprite_frames
	animated_sprite2d.animation = "idle"
	animated_sprite2d.play()

func get_height():
	var height = sprite_frames.get_frame_texture("idle", 0).get_height()
	print("Character.get_height ", height)
	return height
