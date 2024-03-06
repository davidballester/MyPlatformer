extends Area2D
class_name Collectible

signal collected
@export var sprite_frames: SpriteFrames
@export var sfx_player: SFXPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.sprite_frames = sprite_frames

func _on_body_entered(_body):
	collected.emit()
	sfx_player.play("res://assets/sounds/collectible.wav")
	queue_free()
