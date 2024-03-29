extends Object
class_name Stats

var collectibles_collected: int = 0
var time_s: float = 0
var hits: int = 0

func reset() -> void:
	collectibles_collected = 0
	time_s = 0
	hits = 0

func _to_string() -> String:
	return "Stats[collectibles_collected=" + str(collectibles_collected) + ", time_s=" + str(time_s) + ", hits=" + str(hits) + "]"
