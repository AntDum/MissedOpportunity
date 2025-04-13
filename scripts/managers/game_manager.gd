extends Node
class_name GameManager

const LOST_MENU = "res://scenes/ui/menu/lost_menu.tscn"

var day = 0
var meeting = 0

func _enter_tree() -> void:
	EventBus.end_scene_transition.connect(start_game)
	EventBus.day_started.connect(_day_started)
	EventBus.end_of_meeting.connect(_end_meeting)
	EventBus.day_ended.connect(_day_ended)
	EventBus.lost.connect(lost)

func start_game() -> void:
	print("Start game")
	day = 0
	meeting = 0
	EventBus.game_started.emit()
	start_day()

func start_day() -> void:
	print("Start day")
	day += 1
	meeting = 0
	EventBus.start_of_day.emit(day)
	start_meeting()

func end_day() -> void:
	print("End day")
	EventBus.end_of_day.emit()

func start_meeting() -> void:
	print("Start meeting")
	meeting += 1
	EventBus.start_of_meeting.emit(meeting)


func _day_started() -> void:
	print("Day started")	
	start_meeting()

func _day_ended() -> void:
	print("Day ended")	
	if day == 5:
		win()
	else:
		start_day()

func _end_meeting() -> void:
	print("Meeting ended")	
	if meeting == 3:
		end_day()
	else:
		start_meeting()

func end_game() -> void:
	print("End game")	
	EventBus.game_over.emit()
	SceneManager.swap_scene(LOST_MENU)

func lost() -> void:
	end_game()

func win() -> void:
	EventBus.win.emit()
	end_game()
