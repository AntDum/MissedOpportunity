extends Node
class_name RessourceManager

@export_group("Node connexion")
@export var accepted_bin : RestPoint 
@export var refused_bin : RestPoint

@export var offer_holder : Node
@export var spawn_point : Control

const OFFER = preload("res://scenes/levels/offer.tscn")

var fundings = []

var day = 0
var meeting = 0
@export_group("")
@export var start_budget = 50
var budget = 50
@export var salary = -50


func _ready() -> void:
	EventBus.start_of_day.connect(_new_day)
	EventBus.start_of_meeting.connect(_new_meeting)
	EventBus.meeting_started.connect(_start_meeting)
	EventBus.end_of_meeting.connect(_end_meeting)
	EventBus.end_of_day.connect(_end_day)
	budget = start_budget

func get_difficulty() -> int:
	return roundi((10 * meeting) + (10 * day))

func _start_meeting() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var offset = Vector2(15, 15)
	for i in range(3):
		var offer = OFFER.instantiate()
		offer.set_funding(Funding.new(get_difficulty()))
		offer_holder.add_child(offer)
		offer.global_position.x = spawn_point.global_position.x + offset.x * i
		offer.global_position.y = -300
		tween.tween_property(offer, "global_position:y", spawn_point.global_position.y + offset.y * i, 0.5)


func _end_meeting() -> void:
	for fund in accepted_bin.get_fundings():
		fundings.append(fund)
		budget -= fund.get_cost()
	EventBus.money_updated.emit(budget)
	accepted_bin.clear()
	refused_bin.clear()
	for child in offer_holder.get_children():
		child.queue_free()

func _end_day() -> void:
	var total_cost = 0
	var total_benf = 0
	for fund : Funding in fundings:
		total_cost += fund.get_cost()
		total_benf += fund.get_benefit()
	var result = DayResult.new(start_budget, -total_cost, salary, total_benf)
	start_budget = result.get_total()
	budget = start_budget
	EventBus.money_updated.emit(budget)
	EventBus.result_day.emit(result)

func _new_day(new_day: int) -> void:
	day = new_day
	EventBus.money_updated.emit(start_budget)
	fundings.clear()
	
func _new_meeting(new_meeting: int) -> void:
	meeting = new_meeting
