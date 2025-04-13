extends Control

@onready var score: AnimatedCounter = %Money

func _enter_tree() -> void:
	EventBus.money_updated.connect(_on_score_updated)

func _exit_tree() -> void:
	EventBus.money_updated.disconnect(_on_score_updated)

func _on_score_updated(new_score: int) -> void:
	if new_score < 0:
		score.label_settings.font_color = Color.RED
	else:
		score.label_settings.font_color = Color.GREEN
	score.set_value(new_score)

func _on_day_finished() -> void:
	var total = 0
	for child in get_tree().get_nodes_in_group("restPoint"):
		total += child.get_fundings().size()
	if total == 3:
		EventBus.end_of_meeting.emit()
