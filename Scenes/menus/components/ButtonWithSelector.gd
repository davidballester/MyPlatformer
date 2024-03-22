extends Control
class_name ButtonWithSelector

signal clicked()

@export var text: String = "TODO"

func _ready() -> void:
	blur()
	%Label.text = text
	%AnimationPlayer.assigned_animation = "point"

func focus() -> void:
	%PointerContainer.show()
	%AnimationPlayer.play()
	
func blur() -> void:
	%PointerContainer.hide()
	%AnimationPlayer.stop()
	
func is_focused() -> bool:
	return %PointerContainer.visible
	
func _input(_event: InputEvent) -> void:
	if not is_focused() or not Input.is_action_just_pressed("confirm"):
		return
	clicked.emit()
