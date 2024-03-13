extends CharacterBody2D
class_name Character

const JUMP_SOUND = "res://assets/sounds/jump.wav"
const HURT_SOUND = "res://assets/sounds/hurt.wav"

enum AnimationType { IDLE, RUN, JUMP, FALL, HURT, DOUBLE_JUMP }
enum Direction { LEFT, RIGHT }

@export var sprite_frames: SpriteFrames:
	set(new_sprite_frames):
		sprite_frames = new_sprite_frames
		if animated_sprite2d:
			animated_sprite2d.sprite_frames = new_sprite_frames
@export var sfx_player: SFXPlayer
@export var direction: Direction = Direction.RIGHT:
	set(new_direction):
		if not animated_sprite2d:
			return
		animated_sprite2d.flip_h = true if new_direction == Direction.LEFT else false
		direction = new_direction
@export var speed: float = 350.0
@export var inertia: float = 30.0
@export var acceleration: float = 10.0
@export var on_air_acceleration: float = 30.0
@export var jump_velocity: float = -900.0
@export var trampoline_velocity: float = jump_velocity * 2
@export var coyote_time_s: float = 0.15
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var one_way_tilemap: TileMap
@onready var animated_sprite2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var on_coyote_time: bool = false
var can_double_jump: bool = false
var on_trampoline: bool = false
var height: float = 0.0

func _ready():
	if not sprite_frames:
		return
	animated_sprite2d.sprite_frames = sprite_frames
	animated_sprite2d.animation = "idle"
	animated_sprite2d.play()

func get_height():
	if height == 0.0:
		height = sprite_frames.get_frame_texture("idle", 0).get_height()
	return height
	
func take_damage():
	print("Character.take_damage")
	pass
	
func trampoline():
	print("Character.trampoline")
	pass
	
func accelerate_x() -> void:
	var multiplier = -1 if direction == Direction.LEFT else 1
	var acc = acceleration if is_on_floor() else on_air_acceleration
	velocity.x = multiplier * min(
		abs(velocity.x) + acc, 
		speed
	)
	
func inertia_x() -> void:
	velocity.x = move_toward(velocity.x, 0, inertia)
	
func jump() -> void:
	velocity.y = jump_velocity if not on_trampoline else trampoline_velocity
	
func inertia_y(delta: float) -> void:
	var applied_gravity = gravity * 1.5 if velocity.y >= 0 else gravity
	velocity.y += applied_gravity * delta

func drop() -> bool:
	if (
		not one_way_tilemap 
		or not is_on_floor() 
		or get_slide_collision_count() == 0
		or get_slide_collision(0).get_collider().name != "OneWayTerrain"
	):
		return false
	print("Character.drop")
	# XXX: This looks dangerous!
	collision_shape.disabled = true
	get_tree().create_timer(0.1).timeout.connect(func(): collision_shape.disabled = false)
	return true
	
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
