extends Control
class_name Offer

@onready var title: Label = %Title
@onready var cost: Label = %Cost
@onready var min: Label = %Min
@onready var max: Label = %Max

@export var speed : int = 15
@export var rotation_speed : int = 1
@export var reset_rotation_speed : int = 5
@export var snap_distance : int = 150
var selected = false
var offset : Vector2 = Vector2.ZERO

var funding : Funding

var is_snapped = false
var snapped_node : RestPoint
var rest_point : Vector2
var rest_nodes : Array[Node] = []

func _ready() -> void:
	rest_nodes = get_tree().get_nodes_in_group("restPoint")
	_update_visual()

func set_funding(funding: Funding) -> void:
	self.funding = funding
	_update_visual()
	
func _update_visual() -> void:
	if (not funding) or (funding == null): return
	if not is_node_ready(): return
	prints(title, funding)
	title.text = funding.get_title()
	cost.text = str(funding.get_cost())
	min.text = str(funding.get_minimum())
	max.text = str(funding.get_maximum())

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				pivot_offset = size / 2.0 + event.position
				offset = event.position
				selected = true
				is_snapped = true
				move_to_front()
			else:
				pivot_offset = size / 2.0
				selected = false
				is_snapped = false
				var shortest_dist = snap_distance
				var shortest_node = null
				for child in rest_nodes:
					var distance = global_position.distance_to(child.global_position)
					if distance < shortest_dist:
						shortest_node = child
						shortest_dist = distance
				if shortest_node:
					if snapped_node != shortest_node:
						var accepted = shortest_node.select(self)
						if accepted:
							snapped_node = shortest_node as RestPoint
							is_snapped = true
					else:
						is_snapped = true
				else:
					rest_point = Vector2.ZERO
					if snapped_node:
						snapped_node.deselect(self)
					snapped_node = null

func set_rest_point(point: Vector2):
	rest_point = point

func _process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position() - offset, speed  * delta)
		rotation = lerp_angle(rotation,
							-global_position.angle_to(get_global_mouse_position() - offset) * 10,
							rotation_speed * delta)
	elif is_snapped:
		global_position = lerp(global_position, rest_point, speed  * delta)
		rotation = lerp_angle(rotation, 0, reset_rotation_speed * delta)
	else:
		rotation = lerp_angle(rotation, 0, reset_rotation_speed * delta)
		
