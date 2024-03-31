extends Object
class_name LevelLoader

static var levels_paths = [
	"res://scenes/levels/Level1.tscn",
	"res://scenes/levels/Level2.tscn",
	"res://scenes/levels/Level3.tscn"
]

static var next_level: Level
static var next_level_index = -1

static func initialize() -> void:
	print("LevelLoader.initialize")
	next_level = load(levels_paths[0]).instantiate()
	next_level_index = 0
	
static func reset() -> void:
	print("LevelLoader.reset")
	if next_level:
		next_level.queue_free()
	initialize()
	
static func get_next_level() -> Level:
	print("LevelLoader.get_next_level")
	var ans = next_level
	next_level_index += 1
	if next_level_index < levels_paths.size():
		next_level = load(levels_paths[next_level_index]).instantiate()
	else:
		next_level = null
	return ans
	
