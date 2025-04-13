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
	if tot < 0:
		total.label_settings.font_color = Color.RED
	else:
		total.label_settings.font_color = Color.GREEN
	has_result = true
	lost = tot <= 0

func _show() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	var objectif_y = global_position.y
	global_position.y -= 1000
	visible = true
	tween.tween_property(self, "global_position:y", objectif_y + 50, 0.3)
	tween.tween_property(self, "global_position:y", objectif_y, 0.1)
	
func _hide() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var objectif_y = global_position.y
	tween.tween_property(self, "global_position:y", global_position.y + 50, 0.1)
	tween.tween_property(self, "global_position:y", global_position.y - 1000, 0.3)
	tween.tween_callback(func(): visible = false)
	tween.tween_callback(func(): global_position.y = objectif_y)
