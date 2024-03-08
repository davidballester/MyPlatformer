extends Node
class_name VisibilityAwareSFXPlayer

const PLAYERS_COUNT = 10

var players = Array()
var current_player = 0

func _init():
	for i in range(PLAYERS_COUNT):
		var player = AudioStreamPlayer.new()
		add_child(player)
		players.append(player)
		
func play(sfx: VisibilityAwareSFX) -> Callable:
	print("VisibilityAwareSFXPlayer.play ", sfx)
	var audio_stream = load(sfx.sound_path)
	var player: AudioStreamPlayer = players[current_player]
	player.stream = audio_stream
	var bound_unmute = unmute.bind(player, audio_stream, sfx)
	var bound_mute = mute.bind(player, audio_stream, sfx)
	sfx.visibility_notifier.screen_entered.connect(bound_unmute)
	sfx.visibility_notifier.screen_exited.connect(bound_mute)
	if sfx.visibility_notifier.is_on_screen():
		unmute(player, audio_stream, sfx)
	else:
		mute(player, audio_stream, sfx)
	player.play()
	current_player = (current_player + 1) % PLAYERS_COUNT
	return func():
		if player.stream != audio_stream:
			return
		player.stop()
		sfx.visibility_notifier.screen_entered.disconnect(bound_unmute)
		sfx.visibility_notifier.screen_exited.disconnect(bound_mute)
		
func unmute(player: AudioStreamPlayer, audio_stream: AudioStream, sfx: VisibilityAwareSFX) -> void:
	if player.stream != audio_stream:
		sfx.visibility_notifier.screen_entered.disconnect(unmute.bind(player, audio_stream, sfx))
		sfx.visibility_notifier.screen_exited.disconnect(mute.bind(player, audio_stream, sfx))
		return
	player.volume_db = 10.0 * log(sfx.volume)
		
func mute(player: AudioStreamPlayer, audio_stream: AudioStream, sfx: VisibilityAwareSFX) -> void:
	if player.stream != audio_stream:
		sfx.visibility_notifier.screen_entered.disconnect(unmute.bind(player, audio_stream, sfx))
		sfx.visibility_notifier.screen_exited.disconnect(mute.bind(player, audio_stream, sfx))
		return
	player.volume_db = 10.0 * log(0)
