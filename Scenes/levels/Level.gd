extends Node
class_name Level

@onready var collectibles = $Collectibles
@onready var sfx_player = $SFXPlayer
@export var character: Character:
	set(new_character):
		character = new_character
		add_child(character)
		if sfx_player:
			character.sfx_player = sfx_player

func _ready():
	for collectible in collectibles.get_children():
		if collectible is Collectible:
			collectible.sfx_player = sfx_player
	if character:
		character.sfx_player = sfx_player
