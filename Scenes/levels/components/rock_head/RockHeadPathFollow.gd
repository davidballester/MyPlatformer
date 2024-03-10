extends PathFollow2D
class_name RockHeadPathFollow

@export var rock_head: RockHead

func _process(delta):
	progress_ratio += delta * rock_head.speed
