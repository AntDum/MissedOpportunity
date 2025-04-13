extends Area2D
class_name clickable

signal clicked
signal hover_enter
signal hover_exit

var is_hover = false

func hovered() -> bool:
	return is_hover

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			clicked.emit()

func _mouse_enter() -> void:
	is_hover = true
	hover_enter.emit()

func _mouse_exit() -> void:
	is_hover = false
	hover_exit.emit()
