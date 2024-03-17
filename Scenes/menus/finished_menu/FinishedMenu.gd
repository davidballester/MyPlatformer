extends CanvasLayer
class_name FinishedMenu

signal finished

func _on_quit_clicked():
	finished.emit()
