extends Node2D
class_name CreditsMenu

signal back_clicked()

func _ready() -> void:
	%BackButton.clicked.connect(func(): back_clicked.emit())
