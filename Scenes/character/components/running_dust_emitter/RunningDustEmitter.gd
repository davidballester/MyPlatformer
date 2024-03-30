extends CPUParticles2D
class_name RunningDustEmitter

@export var character: Character

func _process(_delta: float) -> void:
	match character.direction:
		Character.Direction.RIGHT:
			scale.x = scale.x if scale.x > 0 else -scale.x
			position.x = position.x if position.x < 0 else -position.x
		Character.Direction.LEFT:
			scale.x = scale.x if scale.x < 0 else -scale.x
			position.x = position.x if position.x > 0 else -position.x

func emit_dust() -> void:
	emitting = true
	
func stop_emitting_dust() -> void:
	emitting = false
