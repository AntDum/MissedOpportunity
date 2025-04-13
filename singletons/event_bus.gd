extends Node

signal begin_scene_transition # Fire at the start of the fade in
signal end_scene_transition # Fire at the end of the fade out

signal game_started
signal game_over
signal start_of_day
signal day_started
signal end_of_day
signal day_ended
signal lost

signal add_funding(fundings: Array[Funding])

signal money_updated(money: int)

signal new_best_score
