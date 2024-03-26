extends Node2D
class_name FinishedMenu

signal finished()

func _ready() -> void:
	%BackButton.clicked.connect(func(): finished.emit())
