extends Control

@onready var title: Label = %title

@onready var budget: AnimatedCounter = %budget
@onready var investment: AnimatedCounter = %investment
@onready var salary: AnimatedCounter = %salary
@onready var benefits: AnimatedCounter = %benefits
@onready var total: AnimatedCounter = %total

var has_result = false
var lost = false

func _ready() -> void:
	EventBus.end_of_day.connect(_show)
	EventBus.result_day.connect(_add_result)
	EventBus.start_of_day.connect(_start_day)

func _start_day(new_day: int) -> void:
	title.text = "End of day : %d" % new_day
	
func _on_hover_button_pressed() -> void:
	if not has_result: return
	if lost:
		EventBus.lost.emit()
	else:
		EventBus.day_ended.emit()
	_hide()

func _add_result(result : DayResult) -> void:
	budget.set_value(result.start_budget)
	investment.set_value(result.investment)
	salary.set_value(result.salary)
	benefits.set_value(result.benefits)
	var tot = result.get_total()
	total.set_value(tot)
	has_result = true
	lost = tot <= 0

func _show() -> void:
	visible = true
	
func _hide() -> void:
	visible = false
