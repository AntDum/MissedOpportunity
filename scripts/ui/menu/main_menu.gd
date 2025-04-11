extends Control

const LEVELS = "res://scenes/levels/levels.tscn"
const CREDITS_SCREEN = "res://scenes/ui/menu/credits_screen.tscn"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var scene_to_go : String = ""

func _already_clicked() -> bool:
	return scene_to_go != ""

func _on_play_button_pressed() -> void:
	if _already_clicked(): return
	scene_to_go = LEVELS
	animation_player.play("click_play")

func _on_credits_button_pressed() -> void:
	if _already_clicked(): return
	scene_to_go = CREDITS_SCREEN
	animation_player.play("click_credits")

func _finish_animation() -> void:
	SceneManager.swap_scene(scene_to_go)
	scene_to_go = ""
