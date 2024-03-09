extends CanvasLayer
class_name PauseMenu

signal resume_clicked
signal exit_clicked

func _on_resume_pressed():
	resume_clicked.emit()
	
func _on_exit_pressed():
	exit_clicked.emit()
