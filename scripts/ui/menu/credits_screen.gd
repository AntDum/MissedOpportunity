extends CanvasLayer

const MAIN_MENU = "res://scenes/ui/menu/main_menu.tscn"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("show")

func _finished_out_animation() -> void:
	SceneManager.swap_scene(MAIN_MENU)

func _finished_in_animation() -> void:
	pass

func _on_hover_button_pressed() -> void:
	animation_player.play("hide")
