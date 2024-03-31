extends Node2D
class_name MainMenu

signal started(SpriteFrames)
signal credits_clicked()

@onready var character_selection_buttons: Array:
	get: 
		return %CharacterSelectionButtonsContainer.get_children()
var selected_character_index = 0
var current_character_selected_button: CharacterSelectionButton:
	get:
		return character_selection_buttons[selected_character_index]

func _ready():
	current_character_selected_button.set_selected(true)
	%StartButton.clicked.connect(on_start_clicked)
	%CreditsButton.clicked.connect(on_credits_clicked)
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("go_left"):
		current_character_selected_button.set_selected(false)
		selected_character_index = (selected_character_index - 1) % character_selection_buttons.size()
		current_character_selected_button.set_selected(true)
	if Input.is_action_just_pressed("go_right"):
		current_character_selected_button.set_selected(false)
		selected_character_index = (selected_character_index + 1) % character_selection_buttons.size()
		current_character_selected_button.set_selected(true)

func on_start_clicked():
	var sprite_frames = current_character_selected_button.get_sprite_frames()
	started.emit(sprite_frames)
	
func on_credits_clicked():
	credits_clicked.emit()
