extends Character
class_name PlayableCharacter

@onready var camera: Camera2D = $Camera
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

func take_damage() -> void:
	state_machine.take_damage()
