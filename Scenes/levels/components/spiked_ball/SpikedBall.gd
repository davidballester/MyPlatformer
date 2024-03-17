extends Node2D
class_name SpikedBall

@export var speed: float = 1.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visibility_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	animation_player.play("swing", -1, speed)
	visibility_notifier.screen_entered.connect(play)
	visibility_notifier.screen_exited.connect(pause)
	if visibility_notifier.is_on_screen():
		play()
	else:
		pause()

func _on_ball_body_entered(body):
	if not body is Character:
		return
	var character: Character = body
	character.take_damage()

func pause() -> void:
	animation_player.pause()

func play() -> void:
	animation_player.play()
	
