extends Node
class_name Level

@export var collectibles_required: int
var collectibles_collected: int = 0
@onready var collectibles = $Collectibles
@onready var sfx_player = $SFXPlayer
@onready var character: Character = $Character
@onready var hud: HUD = $HUD
@onready var exit: Exit = $Exit

func _ready() -> void:
	for collectible in collectibles.get_children():
		collectible.sfx_player = sfx_player

func can_exit() -> bool:
	return collectibles_collected >= collectibles_required

func hide_hud() -> void:
	hud.hide()
	
func show_hud() -> void:
	hud.show()
