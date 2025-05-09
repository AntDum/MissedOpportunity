extends Node
class_name AudioManagerScript

var current_music_player : AudioStreamPlayer = null

func play_sound(name: String) -> void:
	var audio_player = get_node(name)
	if not audio_player:
		push_warning("Unknowned sound : %s" % name)
		return
	audio_player.play()

func play_music(name: String) -> void:
	var audio_player = get_node(name)
	if not audio_player:
		push_warning("Unknown sound : %s" % name)
		return
	if audio_player == current_music_player: return
	else:
		if current_music_player: current_music_player.stop()
		audio_player.play()
		current_music_player = audio_player
