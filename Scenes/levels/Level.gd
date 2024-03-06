extends Node
class_name Level

@onready var collectibles = $Collectibles
@onready var sfx_player = $SFXPlayer

func _ready():
	for collectible in collectibles.get_children():
		if collectible is Collectible:
			collectible.sfx_player = sfx_player
