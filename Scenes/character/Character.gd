extends CharacterBody2D
class_name Character

const JUMP_SOUND = "res://assets/sounds/jump.wav"
const HURT_SOUND = "res://assets/sounds/hurt.wav"

enum AnimationType { IDLE, RUN, JUMP, FALL, HURT, DOUBLE_JUMP }
enum Direction { LEFT, RIGHT }

@export var sprite_frames: SpriteFrames
@export var sfx_player: SFXPlayer
@export var direction: Direction = Direction.RIGHT:
	set(new_direction):
		if not animated_sprite2d:
			return
		animated_sprite2d.flip_h = true if new_direction == Direction.LEFT else false
		direction = new_direction
@export var speed: float = 300.0
@export var inertia: float = 50.0
@export var jump_velocity: float = -900.0
@export var trampoline_velocity: float = jump_velocity * 2
@export var coyote_time_s: float = 0.15
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite2d: AnimatedSprite2D = get_node("AnimatedSprite2D")
var on_coyote_time: bool = false
var can_double_jump: bool = false
var on_trampoline: bool = false

func _ready():
	animated_sprite2d.sprite_frames = sprite_frames
	animated_sprite2d.animation = "idle"
	animated_sprite2d.play()

func get_height():
	var height = sprite_frames.get_frame_texture("idle", 0).get_height()
	print("Character.get_height ", height)
	return height
	
func take_damage():
	print("Character.take_damage")
	pass
	
func trampoline():
	print("Character.trampoline")
	pass
	
func set_coyote_time(enabled: bool) -> void:
	on_coyote_time = enabled
	if on_coyote_time:
		get_tree().create_timer(coyote_time_s).timeout.connect(func(): on_coyote_time = false)
		
func set_animation(animation: AnimationType):
	match animation:
		AnimationType.IDLE:
			animated_sprite2d.animation = "idle"
		AnimationType.JUMP:
			animated_sprite2d.animation = "jump"
			sfx_player.play(JUMP_SOUND)
		AnimationType.FALL:
			animated_sprite2d.animation = "fall"
		AnimationType.RUN:
			animated_sprite2d.animation = "run"
		AnimationType.RUN:
			animated_sprite2d.animation = "run"
		AnimationType.HURT:
			animated_sprite2d.animation = "hurt"
			sfx_player.play(HURT_SOUND)
		AnimationType.DOUBLE_JUMP:
			animated_sprite2d.animation = "double_jump"
			sfx_player.play(JUMP_SOUND)
	animated_sprite2d.play()
