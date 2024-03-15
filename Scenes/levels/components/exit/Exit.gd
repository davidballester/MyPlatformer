extends Area2D
class_name Exit

signal entered

@export var sfx_player: SFXPlayer
@onready var emitter: CPUParticles2D = $CPUParticles2D

func _on_body_entered(body):
	if not body is Character:
		return
	entered.emit()
	
func play() -> Signal:
	emitter.emitting = true
	sfx_player.play("res://assets/sounds/exit.wav")
	return get_tree().create_timer(3.0).timeout
