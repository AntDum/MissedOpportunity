extends CanvasLayer

const LEVELS = "res://scenes/levels/levels.tscn"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var title: Label = %Title

@onready var score_value: AnimatedCounter = %ScoreValue
@onready var best_score_value: AnimatedCounter = %BestScoreValue

func _ready() -> void:
	animation_player.play("show")
	if StatManager.bankrupt:
		title.text = "Bankrupt"
	else:
		title.text = "Success"
		

func _finished_in_animation() -> void:
	var tween = create_tween()
	tween.tween_callback(func(): score_value.set_value(StatManager.score))
	tween.tween_interval(1.0)
	tween.tween_callback(func(): best_score_value.set_value(StatManager.best_score))

func _finished_out_animation() -> void:
	SceneManager.swap_scene(LEVELS)

func _on_hover_button_pressed() -> void:
	animation_player.play("hide")
