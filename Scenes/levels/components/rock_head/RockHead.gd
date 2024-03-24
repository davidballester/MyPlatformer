extends AnimatableBody2D
class_name RockHead

const BLINK_PERIOD_S = 3

@export var sfx_player: SFXPlayer
@export var path: Path2D
@export var speed: float = 50.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var top: Area2D = $Top
@onready var particles: GPUParticles2D = $GPUParticles2D
var shaking = false

func _ready() -> void:
	animated_sprite.animation = "idle"
	animated_sprite.play()
	timer.start(BLINK_PERIOD_S)
	timer.timeout.connect(blink)
	animated_sprite.animation_looped.connect(idle)
	particles.emitting = false

func blink() -> void:
	animated_sprite.animation = "blink"
	
func idle() -> void:
	animated_sprite.animation = "idle"
	
func _on_top_body_entered(body):
	if not body is Character:
		return
	sfx_player.play("res://assets/sounds/rockhead.wav", 0.5)
	blink()
	shake()
	timer.stop()
	timer.start(BLINK_PERIOD_S)

func shake() -> void:
	if shaking:
		return
	shaking = true
	particles.emitting = true
	var tween = get_tree().create_tween()
	@warning_ignore("incompatible_ternary")
	var movable_thing: Node2D = path if path else self
	var start_position = Vector2(movable_thing.position)
	var final_position = Vector2(movable_thing.position.x, movable_thing.position.y + 15)
	tween.tween_property(movable_thing, "position", final_position, 0.1)
	tween.tween_property(movable_thing, "position", start_position, 0.4)
	tween.finished.connect(func(): 
		shaking = false
		particles.emitting = false
	)
