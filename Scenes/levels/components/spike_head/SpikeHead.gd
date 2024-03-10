extends Path2D
class_name SpikeHead

const BLINK_PERIOD_S = 3

@export var speed: float = 50.0
@onready var timer = $Timer
@onready var animated_sprite = $SpikeHead/AnimatedSprite2D
@onready var path_follow: PathFollow2D = $PathFollow2D

func _ready() -> void:
	animated_sprite.animation = "idle"
	animated_sprite.play()
	timer.start(BLINK_PERIOD_S)
	timer.timeout.connect(blink)

func _process(delta):
	path_follow.progress += delta * speed

func blink() -> void:
	animated_sprite.animation = "blink"
	animated_sprite.animation_looped.connect(idle)
	
func idle() -> void:
	animated_sprite.animation_looped.disconnect(idle)
	animated_sprite.animation = "idle"

func _on_spike_head_body_entered(body):
	if not body is Character:
		return
	var character: Character = body
	character.take_damage()
