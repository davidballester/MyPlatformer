extends Node2D
class_name SpikedBall

@export var speed: float = 1.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visibility_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	animation_player.play("swing", -1, speed)
	visibility_notifier.screen_entered.connect(unmute)
	visibility_notifier.screen_exited.connect(mute)
	if visibility_notifier.is_on_screen():
		unmute()
	else:
		mute()

func _on_ball_body_entered(body):
	if not body is Character:
		return
	var character: Character = body
	character.take_damage()

func mute() -> void:
	var animation = get_animation()
	animation.track_set_enabled(1, false)

func unmute() -> void:
	var animation = get_animation()
	animation.track_set_enabled(1, true)
	
func get_animation() -> Animation:
	return animation_player.get_animation(animation_player.current_animation)
