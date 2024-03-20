extends Node2D
class_name CameraTravelling

enum Status { NOT_STARTED, STARTED, FINISHED }

signal finished

@export var path_follow: PathFollow2D
@export var camera: Camera2D
@export var speed: int = 250

@onready var path_follower: PathFollower = $PathFollower
var remote_transform: RemoteTransform2D
var status: Status = Status.NOT_STARTED
var last_progress_ratio: float = -1.0
var original_camera: Camera2D

func start() -> void:
	status = Status.STARTED
	original_camera = camera.duplicate()
	remote_transform = RemoteTransform2D.new()
	camera.position_smoothing_enabled = false
	remote_transform.remote_path = camera.get_path()
	path_follow.loop = false
	path_follow.add_child(remote_transform)
	path_follower.path_follow = path_follow
	path_follower.speed = speed

func _process(_delta) -> void:
	if status != Status.STARTED:
		return
	var has_advanced = path_follow.progress_ratio > last_progress_ratio
	if has_advanced:
		last_progress_ratio = path_follow.progress_ratio
		return
	finish()

func finish() -> void:
	status = Status.FINISHED
	finished.emit()
	remote_transform.queue_free()
	camera.replace_by(original_camera)
	queue_free()
