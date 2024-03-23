extends Node2D
class_name CreditsMenu

signal back_clicked()

func _ready() -> void:
	%BackButton.clicked.connect(func(): back_clicked.emit())

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("go_down"):
		%ScrollContainer.scroll_vertical += 10
	elif Input.is_action_pressed("go_up"):
		%ScrollContainer.scroll_vertical -= 10
