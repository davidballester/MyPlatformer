extends Node

@export var path_follow: PathFollow2D
@export var speed: float = 50.0

func _process(delta: float) -> void:
	path_follow.progress += delta * speed

