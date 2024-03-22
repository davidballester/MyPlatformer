extends CanvasLayer
class_name CreditsMenu

signal back_clicked

@onready var back: ButtonWithSelector = $Background/ButtonWithSelectorGroup/Back

# Called when the node enters the scene tree for the first time.
func _ready():
	back.clicked.connect(func(): back_clicked.emit())
