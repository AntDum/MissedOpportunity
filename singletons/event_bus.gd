extends Node

signal begin_scene_transition # Fire at the start of the fade in
signal end_scene_transition # Fire at the end of the fade out

signal game_started
signal game_over

signal start_of_day(day: int)
signal day_started
signal start_of_meeting(meeting: int)
signal meeting_started
signal end_of_meeting
signal end_of_day
signal day_ended
signal win
signal lost

signal add_funding(fundings: Array[Funding])
signal result_day(result : DayResult)
signal money_updated(money: int)

signal new_best_score
