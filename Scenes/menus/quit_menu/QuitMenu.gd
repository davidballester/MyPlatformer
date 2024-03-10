extends CanvasLayer
class_name QuitMenu

signal yes_clicked
signal no_clicked
@onready var yes: ButtonWithSelector = $Background/ButtonWithSelectorGroup/Yes
@onready var no: ButtonWithSelector = $Background/ButtonWithSelectorGroup/No

func _ready() -> void:
	yes.clicked.connect(func(): yes_clicked.emit())
	no.clicked.connect(func(): no_clicked.emit())
