extends Node
class_name Game

@onready var level_container: Node = $LevelContainer
var collectibles_carried_over: int = 0
var character_sprite: SpriteFrames
var saved_level_scene: Node
var stats: Stats = Stats.new()
var count_time: bool = false

func _ready() -> void:
	LevelLoader.initialize()

func start(sprite_frames: SpriteFrames) -> void:
	character_sprite = sprite_frames
	count_time = true
	
func save_level(saved_level: Node) -> void:
	saved_level_scene = saved_level
	
func pause() -> void:
	level_container.get_tree().paused = true
	count_time = false
	
func resume() -> void:
	level_container.get_tree().paused = false
	count_time = true
	
func reset() -> void:
	LevelLoader.reset()
	stats.reset()
	collectibles_carried_over = 0
	if saved_level_scene:
		saved_level_scene.queue_free()
		saved_level_scene = null
		
func next_level(collectibles_required, collectibles_collected) -> void:
	collectibles_carried_over = collectibles_collected - collectibles_required
	stats.collectibles_collected += collectibles_collected

func character_hit() -> void:
	stats.hits += 1
	
func _process(delta: float) -> void:
	if not count_time:
		return
	stats.time_s += delta
