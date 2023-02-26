extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_nb_neutrons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_nb_neutrons():
	var text = "Number of neutrons " + str(get_tree().current_scene.nb_neutrons)
	set_text(text)
