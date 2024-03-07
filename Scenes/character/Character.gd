extends CharacterBody2D
class_name Character

const JUMP_SOUND = "res://assets/sounds/jump.wav"

enum AnimationType { IDLE, RUN, JUMP, FALL }
enum Direction { LEFT, RIGHT }

@export var sprite_frames: SpriteFrames
@export var sfx_player: SFXPlayer
@export var direction: Direction = Direction.RIGHT:
	set(new_direction):
		if not animated_sprite2d:
			return
		animated_sprite2d.flip_h = true if new_direction == Direction.LEFT else false
@export var speed: float = 300.0
@export var inertia: float = 50.0
@export var jump_velocity: float = -900.0
@export var coyote_time_ms: float = 150
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite2d: AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready():
	animated_sprite2d.sprite_frames = sprite_frames
	animated_sprite2d.animation = "idle"
	animated_sprite2d.play()

func get_height():
	var height = sprite_frames.get_frame_texture("idle", 0).get_height()
	print("Character.get_height ", height)
	return height
	
func jump():
	sfx_player.play(JUMP_SOUND)
	
func take_damage():
	print("Character.take_damage")
	pass

func set_animation(animation: AnimationType):
	match animation:
		AnimationType.IDLE:
			animated_sprite2d.animation = "idle"
		AnimationType.JUMP:
			animated_sprite2d.animation = "jump"
		AnimationType.FALL:
			animated_sprite2d.animation = "fall"
		AnimationType.RUN:
			animated_sprite2d.animation = "run"
	animated_sprite2d.play()
