extends CanvasLayer
class_name PauseMenu

signal resume_clicked
signal exit_clicked
@onready var resume: ButtonWithSelector = $Background/ButtonWithSelectorGroup/Resume
@onready var quit: ButtonWithSelector = $Background/ButtonWithSelectorGroup/Quit

func _ready() -> void:
	resume.clicked.connect(func(): resume_clicked.emit())
	quit.clicked.connect(func(): exit_clicked.emit())
