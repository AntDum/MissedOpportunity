extends RefCounted
class_name DayResult

var start_budget : int
var investment : int
var salary : int
var benefits : int

func _init(bugdet : int, invest : int, sal: int, ben: int) -> void:
	start_budget = bugdet
	investment = invest
	salary = sal
	benefits = ben

func get_total() -> int:
	return start_budget + investment + salary + benefits
