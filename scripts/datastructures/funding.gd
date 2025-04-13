extends RefCounted
class_name Funding

func _init(budget: int) -> void:
	pass
	
func get_title() -> String:
	return "Entreprise"

func get_cost() -> int:
	return randi_range(3, 8)

func get_minimum() -> int:
	return randi_range(3, 8)

func get_maximum() -> int:
	return randi_range(3, 8)

func get_benefit() -> int:
	return randi_range(3, 8)
