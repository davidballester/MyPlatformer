extends Area2D
class_name Exit

signal entered

@export var sfx_player: SFXPlayer
@onready var emitter: CPUParticles2D = $CPUParticles2D
var exit_jingle = preload("res://assets/sounds/exit.wav")

func _on_body_entered(body):
	if not body is Character:
		return
	entered.emit()
	
func play() -> Signal:
	emitter.emitting = true
	sfx_player.play_audio_stream(exit_jingle)
	return get_tree().create_timer(3.0).timeout
