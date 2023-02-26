extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "pause")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pause():
	if get_tree().get_current_scene().on_pause:
		get_tree().get_current_scene().on_pause = false
		text = "Pause"
	else:
		get_tree().get_current_scene().on_pause = true
		text = "Play"
