extends Control

func _ready() -> void:
	EventBus.end_of_day.connect(_show)

func _on_hover_button_pressed() -> void:
	EventBus.day_ended.emit()
	_hide()

func _show() -> void:
	visible = true
	
func _hide() -> void:
	visible = false
