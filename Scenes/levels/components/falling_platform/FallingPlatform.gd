extends AnimatableBody2D
class_name FallingPlatform

enum AnimationType { ON, OFF }

@export var fall_after_s: float = 1.0
@export var falling_speed: float = 500.0
@export var recovering_delay_s: float = 1.5
@export var recovering_speed: float = -200.0
@export var sfx_player: SFXPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $FallingPlatformStateMachine
@onready var idle_state: State = $FallingPlatformStateMachine/FallingPlatformIdleState

var initial_position: Vector2
var has_character: bool

func _ready() -> void :
	state_machine.transition_to_state(idle_state)

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
	has_character = true
	
func _on_platform_activation_area_body_exited(body):
	if not body is Character:
		return
	has_character = false

func shake() -> void:
	var tween = get_tree().create_tween()
	var start_position = Vector2(position)
	var final_position = Vector2(position.x, position.y + 15)
	tween.tween_property(self, "position", final_position, 0.1)
	tween.tween_property(self, "position", start_position, 0.4)
