extends Node
class_name FireTrap

enum AnimationType { IDLE, ACTIVE }
enum Sound { START, MIDDLE, END }

@export var idle_time_s: float = 3
@export var active_time_s: float = 2
@export var sfx_player: SFXPlayer
@onready var animated_sprite = $AnimatedSprite2D
@onready var state_machine: FireTrapStateMachine = $FireTrapStateMachine
@onready var fire_area: FireArea = $FireArea
var stop_current_sound

func _ready():
	fire_area.character_entered.connect(set_character)
	fire_area.character_exited.connect(set_character)

func set_animation(animation: AnimationType) -> void: 
	match animation:
		AnimationType.IDLE:
			if stop_current_sound:
				stop_current_sound.call()
			animated_sprite.animation = "off"
		AnimationType.ACTIVE:
			stop_current_sound = sfx_player.play(
				"res://assets/sounds/fire.wav", 
				0.2
			)
			animated_sprite.animation = "on"
	animated_sprite.play()

func set_character(character: Character) -> void:
	state_machine.character = character
