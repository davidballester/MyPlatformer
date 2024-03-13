extends Node
class_name Level

@onready var collectibles = $Collectibles
@onready var sfx_player = $SFXPlayer
@onready var one_way_terrain = $OneWayTerrain
@export var character: Character:
	set(new_character):
		character = new_character
		add_child(character)
		if sfx_player:
			character.sfx_player = sfx_player
		if one_way_terrain:
			character.one_way_tilemap = one_way_terrain

func _ready():
	for collectible in collectibles.get_children():
		if collectible is Collectible:
			collectible.sfx_player = sfx_player
			collectible.animated_sprite.animation = "default"
	if character:
		character.sfx_player = sfx_player
		character.one_way_tilemap = one_way_terrain
