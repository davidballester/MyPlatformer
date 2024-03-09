extends Area2D
class_name Trampoline

@export var sfx_player: SFXPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.animation_looped.connect(func():
		if animated_sprite.animation == "jump":
			set_idle()
	)
	set_idle()

func _on_body_entered(body):
	if not body is Character:
		return
	var character: Character = body
	character.trampoline()
	set_jumping()

func set_idle():
	animated_sprite.animation = "idle"
	animated_sprite.play()
	
func set_jumping():
	animated_sprite.animation = "jump"
	sfx_player.play("res://assets/sounds/trampoline.wav")
	animated_sprite.play()
