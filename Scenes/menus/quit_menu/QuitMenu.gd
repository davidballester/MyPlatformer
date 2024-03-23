extends Node2D
class_name QuitMenu

signal yes_clicked()
signal no_clicked()

func _ready():
	%YesButton.clicked.connect(func(): yes_clicked.emit())
	%NoButton.clicked.connect(func(): no_clicked.emit())
