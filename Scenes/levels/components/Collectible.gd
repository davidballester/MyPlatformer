extends Area2D
class_name Collectible

signal collected
@export var sprite_frames: SpriteFrames
@export var sfx_player: SFXPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.sprite_frames = sprite_frames
	animated_sprite.animation = "default"
	animated_sprite.play()

func _on_body_entered(body):
	if not body is Character:
		return
	collected.emit()
	sfx_player.play("res://assets/sounds/collectible.wav")
	queue_free()
