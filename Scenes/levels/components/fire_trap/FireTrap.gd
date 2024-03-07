extends Node
class_name FireTrap

enum AnimationType { IDLE, ACTIVE }

@export var idle_time_s: float = 3
@export var active_time_s: float = 2
@onready var animated_sprite = $AnimatedSprite2D
@onready var state_machine: FireTrapStateMachine = $FireTrapStateMachine
@onready var fire_area: FireArea = $FireArea

func _ready():
	fire_area.character_entered.connect(set_character)
	fire_area.character_exited.connect(set_character)

func set_animation(animation: AnimationType) -> void: 
	match animation:
		AnimationType.IDLE:
			animated_sprite.animation = "off"
		AnimationType.ACTIVE:
			animated_sprite.animation = "on"
	animated_sprite.play()

func set_character(character: Character) -> void:
	state_machine.character = character
