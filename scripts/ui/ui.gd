extends CanvasLayer

@onready var score: AnimatedCounter = %Money

@export var accepted_bin : RestPoint 
@export var refused_bin : RestPoint


func _enter_tree() -> void:
	EventBus.money_updated.connect(_on_score_updated)

func _exit_tree() -> void:
	EventBus.money_updated.disconnect(_on_score_updated)

func _on_score_updated(new_score: int) -> void:
	score.set_value(new_score)


func _on_day_finished() -> void:
	print("Accepted", accepted_bin.get_fundings())
	print("Refused", refused_bin.get_fundings())
