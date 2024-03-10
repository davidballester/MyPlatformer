extends Control
class_name CharacterSelectionButton

@onready var corners: Control = $Corners

func _ready() -> void:
	corners.hide()

func set_selected(selected: bool) -> void:
	if selected:
		corners.show()
	else:
		corners.hide()
		
func get_sprite_frames() -> SpriteFrames:
	for child in get_children():
		if child is Character:
			return child.sprite_frames
	return null
