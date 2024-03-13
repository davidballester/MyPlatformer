extends AnimatableBody2D
class_name FallingPlatform

enum AnimationType { ON, OFF }

@export var fall_after_s: float = 1.0
@export var falling_speed: float = 500.0
@export var recovering_delay_s: float = 1.5
@export var recovering_speed: float = -200.0
@export var sfx_player: SFXPlayer
@export var main_character: Character
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $FallingPlatformStateMachine
@onready var idle_state: State = $FallingPlatformStateMachine/FallingPlatformIdleState
@onready var collision_shape = $CollisionShape2D
@onready var activation_area_collision_shape = $PlatformActivationArea/CollisionShape2D

var initial_position: Vector2
var character: Character

func _ready() -> void :
	state_machine.transition_to_state(idle_state)
	if main_character:
		collision_shape.disabled = true
		activation_area_collision_shape = true

func play_animation(animation_type: AnimationType) -> void:
	if not animated_sprite:
		return
	match animation_type:
		AnimationType.ON:
			animated_sprite.animation = "on"
		AnimationType.OFF:
			animated_sprite.animation = "off"
			sfx_player.play("res://assets/sounds/falling_platform.wav", 0.5)
	animated_sprite.play()

func _on_platform_activation_area_body_entered(body):
	if not body is Character:
		return
	character = body
	
func _on_platform_activation_area_body_exited(body):
	if not body is Character:
		return
	character = null

func shake() -> void:
	var tween = get_tree().create_tween()
	var start_position = Vector2(position)
	var final_position = Vector2(position.x, position.y + 15)
	tween.tween_property(self, "position", final_position, 0.1)
	tween.tween_property(self, "position", start_position, 0.4)

func _physics_process(_delta) -> void:
	if not main_character:
		return
	var is_character_above_platform = main_character.position.y + main_character.get_height() > position.y
	collision_shape.disabled = is_character_above_platform
	activation_area_collision_shape = is_character_above_platform
		
