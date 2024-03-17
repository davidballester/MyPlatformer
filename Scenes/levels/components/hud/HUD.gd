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
		label.modulate.a = 1.0
		flash()
		
func flash() -> void:
	var tween = get_tree().create_tween()
	for i in range(5):
		tween.tween_property(score, "modulate:a", 0, 0.15)
		tween.tween_property(score, "modulate:a", 1, 0.15)	
