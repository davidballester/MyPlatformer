extends AudioStreamPlayer

var songs_paths = [
	"res://assets/music/seth_makes_sounds__bubbglegum-pop-song.wav",
	"res://assets/music/seth_makes_sounds__fun-little-happy-song.wav",
	"res://assets/music/seth_makes_sounds__some-game-music-120bpm.wav"
]
var current_song_path_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	finished.connect(on_song_finished)
	play_song()
	
func on_song_finished():
	current_song_path_index = (current_song_path_index + 1) % songs_paths.size()
	play_song()
	
func play_song():
	var song_path = songs_paths[current_song_path_index]
	print("MusicPlayer.play_song ", song_path)
	stream = load(song_path)
	# play()
