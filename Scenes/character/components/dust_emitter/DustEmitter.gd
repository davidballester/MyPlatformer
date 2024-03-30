extends CPUParticles2D
class_name DustEmitter

@export var character: Character

func _process(_delta: float) -> void:
	match character.direction:
		Character.Direction.RIGHT:
			%DustEmitter.scale.x = %DustEmitter.scale.x if %DustEmitter.scale.x > 0 else -%DustEmitter.scale.x
			%DustEmitter.position.x = %DustEmitter.position.x if %DustEmitter.position.x < 0 else -%DustEmitter.position.x
		Character.Direction.LEFT:
			%DustEmitter.scale.x = %DustEmitter.scale.x if %DustEmitter.scale.x < 0 else -%DustEmitter.scale.x
			%DustEmitter.position.x = %DustEmitter.position.x if %DustEmitter.position.x > 0 else -%DustEmitter.position.x

func emit_dust() -> void:
	%DustEmitter.emitting = true
	
func stop_emitting_dust() -> void:
	%DustEmitter.emitting = false
