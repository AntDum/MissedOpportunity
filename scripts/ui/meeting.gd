extends Control

@onready var meeting: Label = %meeting
@onready var budget: Label = %budget
@onready var title: Label = %title

func _ready() -> void:
	EventBus.start_of_day.connect(_start_day)
	EventBus.start_of_meeting.connect(_start_meeting)
	EventBus.money_updated.connect(_update_budget)

func _start_day(new_day: int) -> void:
	title.text = "Day : %d" % new_day

func _start_meeting(new_meeting: int) -> void:
	meeting.text = "%d/3" % new_meeting
	_show()

func _update_budget(new_budget: int) -> void:
	budget.text = "%d €" % new_budget

func _on_hover_button_pressed() -> void:
	EventBus.meeting_started.emit()
	_hide()

func _show() -> void:
	visible = true
	
func _hide() -> void:
	visible = false
