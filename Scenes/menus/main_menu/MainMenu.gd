extends CanvasLayer
class_name MainMenu

signal started

@onready var start: Button = get_node("Background/Start")
var character_sprite_frames: SpriteFrames

func _ready():
	start.disabled = true
	for character_selection_button: CharacterSelectionButton in get_character_selection_buttons():
		character_selection_button.toggled.connect(on_character_selection_button_toggled.bind(character_selection_button))
	start.pressed.connect(on_start_pressed)

func on_character_selection_button_toggled(toggled: bool, character_selection_button: CharacterSelectionButton):
	for another_character_selection_button: CharacterSelectionButton in get_character_selection_buttons():
		if another_character_selection_button != character_selection_button:
			another_character_selection_button.set_pressed_no_signal(false)
	if toggled:
		var character: Character = character_selection_button.get_node("Character")
		character_sprite_frames = character.sprite_frames
		start.disabled = false
	else:
		character_sprite_frames = null
		start.disabled = true
		
func on_start_pressed():
	if not character_sprite_frames:
		pass
	started.emit(character_sprite_frames)

func get_character_selection_buttons():
	var character_selection_buttons: Array = Array()
	for child in get_children():
		if child is CharacterSelectionButton:
			var character_selection_button: CharacterSelectionButton = child
			character_selection_buttons.push_back(character_selection_button)
	return character_selection_buttons
