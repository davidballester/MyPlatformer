extends CanvasLayer
class_name HUD

@onready var label: Label = $Layout/Score/Label

func set_points(points: int):
	if not label:
		return
	label.text = str(points)
