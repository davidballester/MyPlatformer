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
@export var coyote_time_s: float = 0.15
@export var one_way_tilemap: TileMap

@onready var animated_sprite2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var camera: Camera2D = $Camera
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var jump_component: JumpComponent = $JumpComponent
@onready var running_component: RunningComponent = $RunningComponent

var on_coyote_time: bool = false
var can_double_jump: bool = false
var extra_jump_velocity: float = 0.0

func _ready():
	if not sprite_frames:
		return
	animated_sprite2d.sprite_frames = sprite_frames
	animated_sprite2d.animation = "idle"
	animated_sprite2d.play()

func take_damage() -> void:
	state_machine.take_damage()

func jump() -> void:
	jump_component.jump(extra_jump_velocity)
	
func enter_jump_state() -> void:
	can_double_jump = true
	state_machine.jump()
	
func cut_jump() -> void:
	jump_component.cut_jump()
	
func inertia_y(delta: float) -> void:
	jump_component.inertia(delta)

func accelerate_x(delta: float) -> void:
	running_component.accelerate(delta)
	
func inertia_x() -> void:
	running_component.inertia()

func add_jump_velocity(value: float, duration_s: float) -> void:
	extra_jump_velocity += value
	get_tree().create_timer(duration_s).timeout.connect(
		func(): extra_jump_velocity -= value
	)

func drop() -> bool:
	if (
		not one_way_tilemap 
		or not is_on_floor() 
		or get_slide_collision_count() == 0
		or get_slide_collision(0).get_collider().name != "OneWayTerrain"
	):
		return false
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
