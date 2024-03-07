extends StateMachine
class_name FireTrapStateMachine

@export var fire_trap: FireTrap
@export var character: Character:
	set(c):
		for child in get_children():
			if child is FireTrapState:
				child.character = c

func _ready():
	for child in get_children():
		if child is FireTrapState:
			child.fire_trap = fire_trap

