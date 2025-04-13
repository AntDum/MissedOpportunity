extends Control
class_name RestPoint

@export var rest_offset : Vector2 = Vector2(10, 10)
@export var maximum = 3
var offers : Array[Offer] = []

func get_fundings() -> Array[Funding]:
	var fundings : Array[Funding] = []
	for child in offers:
		fundings.append(child.funding)
	return fundings

func clear() -> void:
	offers.clear()

func select(funding: Offer) -> bool:
	if offers.has(funding): return true
	if offers.size() >= maximum: return false
	for child : RestPoint in get_tree().get_nodes_in_group("restPoint"):
		child.deselect(funding)
	offers.append(funding)
	_reset_rest()
	return true

func deselect(funding: Offer) -> void:
	offers.erase(funding)
	_reset_rest()

func _reset_rest() -> void:
	var n = 0
	for child in offers:
		child.set_rest_point(global_position + rest_offset * n)
		n += 1
		
