extends Node

var score : int = 0
var best_score : int = 0
var beat_best_score : bool = false

func _ready() -> void:
	EventBus.score_updated.connect(_on_score_updated)
	EventBus.game_started.connect(_on_game_started)

func _on_game_started() -> void:
	score = 0

func _on_score_updated(new_score) -> void:
	score = new_score
	if score > best_score:
		best_score = score
		if not beat_best_score:
			EventBus.new_best_score.emit()
		beat_best_score = true
