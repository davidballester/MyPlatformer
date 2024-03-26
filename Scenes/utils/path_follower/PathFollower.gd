extends PathFollow2D
class_name PathFollower

@export var speed: float = 50
@export var node: Node2D:
	set(n):
		node = n
		if not node.is_inside_tree():
			await node.tree_entered
		var remote_transfer = RemoteTransform2D.new()
		remote_transfer.remote_path = node.get_path()
		remote_transfer.use_global_coordinates = true
		remote_transfer.update_position = true
		remote_transfer.update_rotation = false
		remote_transfer.update_scale = false
		add_child(remote_transfer)

func _process(delta: float) -> void:
	if not node:
		return
	progress += delta * speed
