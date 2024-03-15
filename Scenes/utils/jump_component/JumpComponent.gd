extends Node
class_name JumpComponent

@export var character: CharacterBody2D
@export var jump_height: float = Globals.TILE_SIZE * 3
@export var jump_time_to_peak_s: float = 0.5
@export var jump_time_to_descent_s: float = 0.3

@onready var jump_velocity: float = -(2.0 * jump_height) / jump_time_to_peak_s
@onready var jump_gravity: float = (2.0 * jump_height) / pow(jump_time_to_peak_s, 2)
@onready var fall_gravity: float =  (2.0 * jump_height) / pow(jump_time_to_descent_s, 2)
	
func jump(extra_jump_velocity: float) -> void:
	character.velocity.y = jump_velocity + extra_jump_velocity
	
func inertia(delta: float) -> void:
	character.velocity.y += get_gravity() * delta
	
func cut_jump() -> void:
	if character.velocity.y >= 0:
		return
	character.velocity.y /= 2
	
func get_gravity() -> float:
	return fall_gravity if is_falling() else jump_gravity

func is_falling() -> bool:
	return character.velocity.y >= 0
