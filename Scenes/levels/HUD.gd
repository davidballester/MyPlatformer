extends CanvasLayer
class_name HUD

@onready var label: Label = get_node("Panel/Label")

func set_points(points: int):
	if not label:
		return
	label.text = str(points)
