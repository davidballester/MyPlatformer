extends Node2D
class_name Character

const JUMP_SOUND = "res://assets/sounds/jump.wav"

enum ANIMATION { IDLE, RUN, JUMP, FALL }
enum DIRECTION { LEFT, RIGHT }

@export var sprite_frames: SpriteFrames
@export var sfx_player: SFXPlayer
@onready var animated_sprite2d: AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready():
	animated_sprite2d.sprite_frames = sprite_frames
	set_animation(ANIMATION.IDLE, DIRECTION.RIGHT)
	animated_sprite2d.animation = "idle"
	animated_sprite2d.play()

func get_height():
	var height = sprite_frames.get_frame_texture("idle", 0).get_height()
	print("Character.get_height ", height)
	return height
	
func jump():
	sfx_player.play(JUMP_SOUND)

func set_animation(animation: ANIMATION, direction: DIRECTION):
	match animation:
		ANIMATION.IDLE:
			animated_sprite2d.animation = "idle"
		ANIMATION.JUMP:
			animated_sprite2d.animation = "jump"
		ANIMATION.FALL:
			animated_sprite2d.animation = "fall"
		ANIMATION.RUN:
			animated_sprite2d.animation = "run"
	match direction:
		DIRECTION.LEFT:
			animated_sprite2d.flip_h = true
		DIRECTION.RIGHT:
			animated_sprite2d.flip_h = false
