extends Label
class_name RewriteLabel

@export_multiline var start_text : String = ""

@export_category("Animation")
@export var erase_transition : Tween.TransitionType = Tween.TRANS_CUBIC
@export var erase_easing : Tween.EaseType = Tween.EASE_OUT
@export var erase_duration : float = 1

@export var in_between_delay : float = 0.1

@export var rewrite_transition : Tween.TransitionType = Tween.TRANS_CUBIC
@export var rewrite_easing : Tween.EaseType = Tween.EASE_OUT
@export var rewrite_duration : float = 1

func _ready() -> void:
	change_text(start_text)

var tween : Tween

func change_text(new_text : String) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	# Erase
	if text.length() > 0:
		tween.tween_property(self, "visible_ratio", 0, erase_duration).set_ease(erase_easing).set_trans(erase_transition)
		tween.tween_interval(in_between_delay)	
	else:
		visible_ratio = 0
	# Change Value
	tween.tween_callback(func(): text = new_text)
	
	# Rewrite
	if new_text.length() > 0:
		tween.tween_property(self, "visible_ratio", 1, rewrite_duration).set_ease(rewrite_easing).set_trans(rewrite_transition)
	else:
		visible_ratio = 1
	
