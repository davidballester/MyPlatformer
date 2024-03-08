extends Area2D
class_name Spikes

func _on_body_entered(body):
	if not body is Character:
		return
	var character: Character = body
	character.take_damage()
