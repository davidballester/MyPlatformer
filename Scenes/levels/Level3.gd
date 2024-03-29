extends Level
class_name Level3

@export var game: Game

func _ready() -> void:
	collectibles_required = collectibles_collected + 1
	hud.update()
