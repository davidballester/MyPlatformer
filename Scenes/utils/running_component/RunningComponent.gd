extends Node
class_name RunningComponent

@export var character: Character
@export var on_floor_acceleration: float
@export var on_air_acceleration: float
@export var min_speed: float
@export var max_speed: float
@onready var inertia_value: float = max_speed / 10

func accelerate(delta: float) -> void:
	var direction_multiplier = -1 if is_facing_left() else 1
	var acceleration = on_floor_acceleration if character.is_on_floor() else on_air_acceleration
	var speed = min(
		abs(character.velocity.x) + acceleration * delta, 
		max_speed
	)
	character.velocity.x = direction_multiplier * max(min_speed, speed)
	
func inertia() -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, inertia_value)
	
func is_facing_left() -> bool:
	return character.direction == Character.Direction.LEFT
