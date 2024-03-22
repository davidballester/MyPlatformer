extends Control
class_name CharacterSelectionButton

@export var sprite_frames: SpriteFrames

func _ready() -> void:
	%SelectionIndicator.hide()
	%AnimatedSprite2D.sprite_frames = sprite_frames
	%AnimatedSprite2D.animation = "idle"
	%AnimatedSprite2D.play()

func set_selected(selected: bool) -> void:
	if selected:
		%SelectionIndicator.show()
	else:
		%SelectionIndicator.hide()
		
func get_sprite_frames() -> SpriteFrames:
	return %AnimatedSprite2D.sprite_frames
