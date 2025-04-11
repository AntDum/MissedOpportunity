extends Node
class_name GameManager

const LOST_MENU = "res://scenes/ui/menu/lost_menu.tscn"

func _enter_tree() -> void:
	EventBus.end_scene_transition.connect(start_game)

func start_game() -> void:
	EventBus.game_started.emit()

func end_game() -> void:
	EventBus.game_over.emit()
	SceneManager.swap_scene(LOST_MENU)

func lost() -> void:
	end_game()

func win() -> void:
	end_game()
