extends Node2D
class_name PauseMenu

signal resume_clicked()
signal exit_clicked()

func _ready() -> void:
	%ResumeButton.clicked.connect(func(): resume_clicked.emit())
	%QuitButton.clicked.connect(func(): exit_clicked.emit())
