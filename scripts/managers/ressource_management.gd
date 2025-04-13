extends Node
class_name RessourceManager

@export var accepted_bin : RestPoint 
@export var refused_bin : RestPoint

@export var offer_holder : Node
@export var spawn_point : Control

const OFFER = preload("res://scenes/levels/offer.tscn")

var fundings = []

var day = 0
var meeting = 0
@export var budget = 100

func _ready() -> void:
	EventBus.start_of_day.connect(_new_day)
	EventBus.start_of_meeting.connect(_new_meeting)
	EventBus.meeting_started.connect(_start_meeting)
	EventBus.end_of_meeting.connect(_end_meeting)

func get_difficulty() -> int:
	return roundi(budget / 10.0)

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
	accepted_bin.clear()
	refused_bin.clear()
	for child in offer_holder.get_children():
		child.queue_free()

func _new_day(new_day: int) -> void:
	day = new_day
	
func _new_meeting(new_meeting: int) -> void:
	meeting = new_meeting
