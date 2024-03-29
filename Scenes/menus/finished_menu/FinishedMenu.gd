extends Node2D
class_name FinishedMenu

signal finished()

func _ready() -> void:
	%BackButton.clicked.connect(func(): finished.emit())
	
func show_stats(stats: Stats) -> void:
	%TimeValue.text = str(round(stats.time_s)) + "s"
	%CollectiblesValues.text = str(stats.collectibles_collected)
	%TimesHitValue.text = str(stats.hits)
