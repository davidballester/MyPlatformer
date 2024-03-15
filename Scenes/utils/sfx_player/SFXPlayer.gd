extends Node
class_name SFXPlayer

const PLAYERS_COUNT = 5

var players = Array()
var current_player = 0

func _init():
	for i in range(PLAYERS_COUNT):
		var player = AudioStreamPlayer.new()
		add_child(player)
		players.append(player)
		
func play(sfx_path: String, volume: float = 1.0) -> Callable:
	print("SFXPlayer.play ", sfx_path, " ", volume)
	var audio_stream = load(sfx_path)
	var player: AudioStreamPlayer = players[current_player]
	player.stream = audio_stream
	player.volume_db = 10.0 * log(volume)
	player.play()
	current_player = (current_player + 1) % PLAYERS_COUNT
	return func():
		if player.stream == audio_stream:
			player.stop()
