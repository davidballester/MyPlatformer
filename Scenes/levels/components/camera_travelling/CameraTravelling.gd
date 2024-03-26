extends Node2D
class_name CameraTravelling

enum Status { NOT_STARTED, STARTED, FINISHED }

signal finished

@export var path: Path2D
@export var camera: Camera2D
@export var speed: float = 250.0

var status: Status = Status.NOT_STARTED
var last_progress_ratio: float = -1.0
var original_camera: Camera2D
var path_follower: PathFollower

func start() -> void:
	status = Status.STARTED
	original_camera = camera.duplicate()
	camera.position_smoothing_enabled = false
	path_follower = PathFollower.new()
	path_follower.speed = speed
	path_follower.node = camera
	path_follower.loop = false
	path.add_child(path_follower)

func _process(_delta) -> void:
	if status != Status.STARTED:
		return
	var has_advanced = path_follower.progress_ratio > last_progress_ratio
	if has_advanced:
		last_progress_ratio = path_follower.progress_ratio
		return
	finish()

func finish() -> void:
	status = Status.FINISHED
	finished.emit()
	path_follower.queue_free()
	camera.replace_by(original_camera)
	queue_free()
