extends CanvasLayer
class_name SceneTransition

const COLOR = Color.BLACK
const DURATION_S: float = 1.0

signal roll_in_finished
signal roll_out_finished

@export var rectangles_count: int = 10

var rectangles: Array = Array()

func _ready() -> void:
	for i in range(0, rectangles_count):
		var rectangle = create_rectangle(i)
		add_child(rectangle)
		rectangles.append(rectangle)
		
func roll_in() -> Signal:
	call_deferred("roll", get_final_position_y, roll_in_finished)
	return roll_in_finished
		
func roll_out() -> Signal:
	call_deferred("roll", get_start_position_y, roll_out_finished)
	return roll_out_finished
		
func roll(get_position_y: Callable, s: Signal) -> void:
	var animations = Array()
	for rectangle in rectangles:
		var final_position = Vector2(rectangle.position)
		final_position.y = get_position_y.call()
		var animation_finished = animate_rectangle(rectangle, final_position)
		animations.append(animation_finished)
	for animation in animations:
		await animation
	s.emit()

func create_rectangle(index: int) -> ColorRect:
	var rectangle = ColorRect.new()
	rectangle.color = COLOR
	var rectangle_width = float(Globals.SCREEN_WIDTH) / float(rectangles_count)
	rectangle.size = Vector2(
		rectangle_width,
		Globals.SCREEN_HEIGHT + 50
	)
	@warning_ignore("integer_division")
	rectangle.position = Vector2(
		index * rectangle_width,
		get_start_position_y()
	)
	return rectangle

func animate_rectangle(rectangle: ColorRect, position: Vector2) -> Signal:
	var tween = get_tree().create_tween()
	tween.tween_property(rectangle, "position", position, DURATION_S)
	return tween.finished

func get_start_position_y() -> int:
	@warning_ignore("integer_division")
	return - Globals.SCREEN_HEIGHT - randi_range(int(Globals.SCREEN_HEIGHT / 2), Globals.SCREEN_HEIGHT)
	
func get_final_position_y() -> int:
	return -25
