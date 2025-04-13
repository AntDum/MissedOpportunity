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
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	var objectif_y = global_position.y
	global_position.y -= 1000
	visible = true
	tween.tween_property(self, "global_position:y", objectif_y + 50, 0.3)
	tween.tween_property(self, "global_position:y", objectif_y, 0.1)
	
func _hide() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var objectif_y = global_position.y
	tween.tween_property(self, "global_position:y", global_position.y + 50, 0.1)
	tween.tween_property(self, "global_position:y", global_position.y - 1000, 0.3)
	tween.tween_callback(func(): visible = false)
	tween.tween_callback(func(): global_position.y = objectif_y)
