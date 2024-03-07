extends Area2D
class_name FireArea

signal character_entered
signal character_exited

func _on_body_entered(body):
	if not body is Character:
		return
	character_entered.emit(body)

func _on_body_exited(body):
	if not body is Character:
		return
	character_exited.emit(null)
