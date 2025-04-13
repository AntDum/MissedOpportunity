extends RefCounted
class_name Funding

const title_first_part = ["Atlantic", "Quantum", "Eco", "North", "Crypto", "Proud", "Emotional", "Healing", "Nostalgic", "Scorching", "Dating", "Flying", "Elemental", "Spooky", "Disguised", "Logical", "Holy", "Western", "Iron"]
const title_second_part = ["Leaf", "Sea", "Pole", "Star", "Lettuce", "Lab", "Group", "Bird", "Damage", "Spikes", "Cow", "G@m3rzzz", "Fruits", "Barbarian", "Gods", "Cheese", "Witches", "Clowns", "Farmers", "B.R.I.D.G.E", "Gate", "Dragon", "Iron", "Legion", "Kings"]

var minimal_benefit = 0
var maximal_benefit = 1
var actual_benefit = 1
var cost = 1
var title = null

@export var dff : Curve


func _init(budget: int) -> void:
	title = title_first_part.pick_random()
	title += " " + title_second_part.pick_random()
	
	minimal_benefit = randi_range(budget/2, budget * 2)
	cost = randi_range(budget * 1.5, budget * 3)
	maximal_benefit = randi_range(budget * 5, budget * 20)
	
	actual_benefit = _compute_benefit(minimal_benefit, maximal_benefit);
	

func _compute_benefit(min, max) -> int:
	var p = randf()
	var benefit = min
	while _cumulative_density_function(benefit, min, max) > p:
		benefit += 1
	return benefit

func _cumulative_density_function(x, m, M) -> int:
	var a = -4/(10 * m)
	var b = 14/10
	var c = 0.2/((27*m**3) - (M**3))
	var d = -c*(M**3)
	if x < m: return 1
	elif x < M : return (a * x) + b
	else : return (c * x**3) + d

func get_title() -> String:
	return title

func get_cost() -> int:
	return cost

func get_minimum() -> int:
	return minimal_benefit

func get_maximum() -> int:
	return maximal_benefit

func get_benefit() -> int:
	return actual_benefit
