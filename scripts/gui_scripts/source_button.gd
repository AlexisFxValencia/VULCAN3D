extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "generate_sources")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func generate_sources():
	for i in int(get_tree().current_scene.get_node("Control/Panel/VBoxContainer/sources/nb_source").get_text()):
		get_tree().current_scene.get_node("Neutrons").add_neutron_init()
