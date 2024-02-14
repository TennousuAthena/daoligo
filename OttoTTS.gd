extends AudioStreamPlayer2D

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound

# Called when the node enters the scene tree for the first time.
func _ready():
	var audio = load_mp3("res://audio/longToken/wssddl.mp3")
	play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
