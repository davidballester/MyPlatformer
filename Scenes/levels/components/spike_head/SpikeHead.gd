extends Area2D
class_name SpikeHead

const BLINK_PERIOD_S = 3

@export var sfx_player: SFXPlayer
@onready var timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.animation = "idle"
	animated_sprite.play()
	timer.start(BLINK_PERIOD_S)
	timer.timeout.connect(blink)

func blink() -> void:
	animated_sprite.animation = "blink"
	animated_sprite.animation_looped.connect(idle, CONNECT_ONE_SHOT)
	
func idle() -> void:
	animated_sprite.animation = "idle"

func _on_body_entered(body):
	if not body is Character:
		return
	var character: Character = body
	character.take_damage()
	blink()
	timer.stop()
	timer.start()
	if sfx_player:
		sfx_player.play("res://assets/sounds/rockhead.wav", 1.0)
	var initial_rotation = rotation
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", initial_rotation + 2.5 * PI, 0.5)
