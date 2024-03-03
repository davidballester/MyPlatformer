extends Node2D
class_name Character

@export var sprite_frames: SpriteFrames
@onready var animated_sprite2d: AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready():
	animated_sprite2d.sprite_frames = sprite_frames
	animated_sprite2d.animation = "idle"
	animated_sprite2d.play()
