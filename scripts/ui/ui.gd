extends CanvasLayer

@onready var score: AnimatedCounter = %Score

func _enter_tree() -> void:
	EventBus.score_updated.connect(_on_score_updated)

func _exit_tree() -> void:
	EventBus.score_updated.disconnect(_on_score_updated)

func _on_score_updated(new_score: int) -> void:
	score.set_value(new_score)
