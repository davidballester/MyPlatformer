extends Control
class_name ButtonWithSelector

signal clicked
@export var text: String = "TODO"
@onready var selector: Control = $Selector
@onready var animation_player: AnimationPlayer = $Selector/AnimationPlayer
@onready var label: Label = $Button/Label

func _ready() -> void:
	blur()
	label.text = text
	animation_player.assigned_animation = "point"

func focus() -> void:
	selector.show()
	animation_player.play()
	
func blur() -> void:
	selector.hide()
	animation_player.stop()
	
func is_focused() -> bool:
	return selector.visible
	
func _input(_event: InputEvent) -> void:
	if not is_focused() or not Input.is_action_just_pressed("confirm"):
		return
	clicked.emit()
