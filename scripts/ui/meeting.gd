extends Control

@onready var meeting: Label = %meeting
@onready var budget: Label = %budget

func _ready() -> void:
	EventBus.start_of_meeting.connect(_start_meeting)
	EventBus.money_updated.connect(_update_budget)

func _start_meeting(new_meeting: int) -> void:
	meeting.text = "%d/3" % new_meeting
	_show()

func _update_budget(new_budget: int) -> void:
	budget.text = str(new_budget)

func _on_hover_button_pressed() -> void:
	EventBus.meeting_started.emit()
	_hide()

func _show() -> void:
	visible = true
	
func _hide() -> void:
	visible = false
