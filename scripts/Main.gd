extends Spatial
export (PackedScene) var neutron_scene

const NB_NEUTRONS_INIT = 200
var nb_neutrons = NB_NEUTRONS_INIT
var child_location = Vector3.ZERO
var reflexions_activated = false
var on_pause = false

func add_neutron():
	var neutron = neutron_scene.instance()
	neutron.transform.origin = child_location
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
