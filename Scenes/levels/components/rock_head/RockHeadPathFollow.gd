extends PathFollow2D
class_name RockHeadPathFollow

@export var rock_head: RockHead

func _ready():
	var remote_transfer = RemoteTransform2D.new()
	remote_transfer.remote_path = rock_head.get_path()
	remote_transfer.use_global_coordinates = true
	remote_transfer.update_position = true
	remote_transfer.update_rotation = false
	remote_transfer.update_scale = false
	add_child(remote_transfer)

func _process(delta):
	if not rock_head:
		return
	progress += delta * rock_head.speed
