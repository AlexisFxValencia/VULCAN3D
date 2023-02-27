extends Spatial
export (PackedScene) var neutron_scene

const NB_NEUTRONS_INIT = 200
var nb_neutrons = NB_NEUTRONS_INIT
var child_location = Vector3.ZERO
var reflexions_activated = false
var on_pause = false

func add_neutron():
	var neutron = neutron_scene.instance()
	var scene = get_tree().get_current_scene()
	neutron.transform.origin = child_location
	add_child(neutron)

func add_neutron_init():	
	var neutron = neutron_scene.instance()
	var scene = get_tree().get_current_scene()
	var x = int(scene.get_node("Control/Panel/VBoxContainer/sources/x_source").text)
	var y = int(scene.get_node("Control/Panel/VBoxContainer/sources/y_source").text)
	var z = int(scene.get_node("Control/Panel/VBoxContainer/sources/z_source").text)
	neutron.transform.origin = Vector3(x, y, z)
	add_child(neutron)	
# Called when the node enters the scene tree for the first time.
func _ready():
	#print("neutron_scene main", neutron_scene)
#	for i in nb_neutrons:
#		add_neutron()
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
