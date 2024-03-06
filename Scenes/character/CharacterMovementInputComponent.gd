extends Node
class_name CharacterMovementInputComponent

enum MovementState { IDLE, JUMPING, FALLING, RUNNING }

const SPEED = 300.0
const INERTIA = 50.0
const JUMP_VELOCITY = -900.0
const ACTION_TO_GRACE_PERIOD_MS: Dictionary = {
	"jump": 150
}
const COYOTE_TIME_MS = 150

@export var character: Character

@onready var input_buffer: InputBuffer = $InputBuffer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_direction: Character.DIRECTION = Character.DIRECTION.RIGHT
var last_time_on_floor_ms: float
var jumping: bool = false
var direction: float
var movement_state: MovementState

func _ready():
	input_buffer.action_to_grace_period_ms = ACTION_TO_GRACE_PERIOD_MS
	
func _process(_delta):
	jumping = on_coyote_time() and input_buffer.is_action_buffered("jump")
	if jumping:
		movement_state = MovementState.JUMPING
	elif character.velocity.y > 0:
		movement_state = MovementState.FALLING
	else:
		direction = Input.get_axis("go_left", "go_right")
		if movement_state != MovementState.JUMPING and movement_state != MovementState.FALLING:
			movement_state = MovementState.RUNNING if direction else MovementState.IDLE

func _physics_process(delta):
	if character.is_on_floor():
		last_time_on_floor_ms = Time.get_ticks_msec()
	if jumping:
		character.velocity.y = JUMP_VELOCITY
	elif not character.is_on_floor():
		var applied_gravity = gravity if character.velocity.y < 0 else gravity * 1.5
		character.velocity.y += applied_gravity * delta
	if direction:
		character.velocity.x = direction * SPEED
		last_direction = get_direction()
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, INERTIA)
		
	set_animation()
	character.move_and_slide()
	
func get_direction():
	return Character.DIRECTION.RIGHT if character.velocity.x > 0 else Character.DIRECTION.LEFT

func on_coyote_time():
	var time_not_on_floor = Time.get_ticks_msec() - last_time_on_floor_ms
	return character.is_on_floor() or time_not_on_floor < COYOTE_TIME_MS
	
func set_animation():
	if character.velocity.y < 0:
		character.set_animation(Character.ANIMATION.JUMP, last_direction)
	elif character.velocity.y > 0:
		character.set_animation(Character.ANIMATION.FALL, last_direction)
	elif character.velocity.x == 0:
		character.set_animation(Character.ANIMATION.IDLE, last_direction)
	else:
		character.set_animation(Character.ANIMATION.RUN, last_direction)
