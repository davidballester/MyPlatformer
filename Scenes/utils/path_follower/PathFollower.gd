extends Node
class_name PathFollower

@export var path_follow: PathFollow2D
@export var speed: float = 50.0

func _process(delta: float) -> void:
	if not path_follow:
		return
	path_follow.progress += delta * speed
