extends Node
class_name AudioManagerScript

func play_sound(name: String) -> void:
	var audio_player = get_node(name)
	if not audio_player:
		push_warning("Unknowned sound : %s" % name)
		return
	audio_player.play()
