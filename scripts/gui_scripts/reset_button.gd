extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "reset")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset():
	get_tree().get_current_scene().get_node("Neutrons").on_pause = true
	get_tree().get_current_scene().get_node("Neutrons").delete_neutrons()
	get_tree().get_current_scene().get_node("Neutrons").on_pause = false
	get_tree().get_current_scene().get_node("Neutrons").nb_neutrons = 0
	get_tree().get_current_scene().get_node("Control/Panel/VBoxContainer/minimal_VBoxContainer/nb_neutrons_label").update_nb_neutrons()

