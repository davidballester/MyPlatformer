extends Node
class_name CharacterMovementInputComponent

const SPEED = 300.0
const INERTIA = 50.0
const JUMP_VELOCITY = -900.0
const JUMP_WHILE_FALLING_GRACE_PERIOD_MS = 150

@export var character: Character

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_time_on_floor_ms: float
var last_direction: Character.DIRECTION = Character.DIRECTION.RIGHT

func _physics_process(delta):
	if not character.is_on_floor():
		character.velocity.y += gravity * delta
	else:
		last_time_on_floor_ms = Time.get_ticks_msec()
		
	if Input.is_action_just_pressed("jump") and was_recently_on_floor():
		character.velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("go_left", "go_right")
	if direction:
		character.velocity.x = direction * SPEED
		last_direction = get_direction()
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, INERTIA)
		
	set_animation()
	character.move_and_slide()
	
func was_recently_on_floor():
	return character.is_on_floor() or Time.get_ticks_msec() - last_time_on_floor_ms < JUMP_WHILE_FALLING_GRACE_PERIOD_MS
	
func get_direction():
	return Character.DIRECTION.RIGHT if character.velocity.x > 0 else Character.DIRECTION.LEFT

func set_animation():
	if character.velocity.y < 0:
		character.set_animation(Character.ANIMATION.JUMP, last_direction)
	elif character.velocity.y > 0:
		character.set_animation(Character.ANIMATION.FALL, last_direction)
	elif character.velocity.x == 0:
		character.set_animation(Character.ANIMATION.IDLE, last_direction)
	else:
		character.set_animation(Character.ANIMATION.RUN, last_direction)
