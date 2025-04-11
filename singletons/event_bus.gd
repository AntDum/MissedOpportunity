extends Node

signal begin_scene_transition # Fire at the start of the fade in
signal end_scene_transition # Fire at the end of the fade out

signal game_started
signal game_over

signal score_updated(score: int)


signal new_best_score
