extends Node
class_name CameraShaker

@export var initial_strength: float = 50.0
@export var decay_rate: float = 15.0

var camera: Camera2D
var finished: Signal
var current_strength: float
	
func shake(n: Camera2D) -> Signal:
	camera = n
	camera.add_child(self)
	current_strength = initial_strength
	finished = Signal()
	return finished
	
func _process(delta: float) -> void:
	if not camera: 
		return
	if current_strength <= 0.1:
		finish()
		return
	current_strength = lerp(current_strength, 0.0, decay_rate * delta)
	var offset = Vector2(
		randf_range(-current_strength, current_strength),
		randf_range(-current_strength, current_strength)
	)
	camera.offset = offset
	
func finish() -> void:
	camera.offset = Vector2(0, 0)
	camera.remove_child(self)
	camera = null
	finished.emit()
	
