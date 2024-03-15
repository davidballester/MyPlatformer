extends CanvasLayer
class_name HUD

@export var level: Level
@onready var score: Control = $Layout/Score
@onready var label: Label = $Layout/Score/Label
var has_passed_requirement: bool = false

func _ready() -> void:
	update()

func update():
	if not label:
		return
	label.text = str(level.collectibles_collected) + "/" + str(level.collectibles_required)
	if not has_passed_requirement and level.can_exit():
		has_passed_requirement = true
		var label_color = label.get_theme_color("font_color")
		var new_label_color = Color(label_color, 1.0)
		label.add_theme_color_override("font_color", new_label_color)
		flash()
		
func flash() -> void:
	var tween = get_tree().create_tween()
	for i in range(5):
		tween.tween_property(score, "modulate:a", 0, 0.15)
		tween.tween_property(score, "modulate:a", 1, 0.15)	
