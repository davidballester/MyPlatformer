extends Path2D
class_name RockHead

const BLINK_PERIOD_S = 3

@export var speed: float = 50.0
@export var sfx_player: SFXPlayer
@onready var animated_sprite: AnimatedSprite2D = $RockHead/AnimatedSprite2D
@onready var path_follow: PathFollow2D = $PathFollow2D
@onready var timer: Timer = $Timer
@onready var top: Area2D = $RockHead/Top

func _ready() -> void:
	animated_sprite.animation = "idle"
	animated_sprite.play()
	timer.start(BLINK_PERIOD_S)
	timer.timeout.connect(blink)
	animated_sprite.animation_looped.connect(idle)

func _process(delta):
	path_follow.progress += delta * speed

func blink() -> void:
	animated_sprite.animation = "blink"
	
func idle() -> void:
	animated_sprite.animation = "idle"
	
func _on_top_body_entered(body):
	if not body is Character:
		return
	sfx_player.play("res://assets/sounds/rockhead.wav", 0.5)
	blink()
	timer.stop()
	timer.start(BLINK_PERIOD_S)
