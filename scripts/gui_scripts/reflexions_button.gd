extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_activate_reflexions")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _activate_reflexions():
	if get_tree().get_current_scene().get_node("Neutrons").reflexions_activated:
		get_tree().get_current_scene().get_node("Neutrons").reflexions_activated = false
		text = "Activate Reflexions"
	else:
		get_tree().get_current_scene().get_node("Neutrons").reflexions_activated = true
		text = "Deactivate Reflexions"
