extends KinematicBody

export (PackedScene) var neutron_scene

export var speed = 2.1
var velocity = Vector3.ZERO
var in_a_volume = false
var mean_free_path = 2.0
#var timer = 0.0
#var time_multiplier = 1.0
var old_position = Vector3.ZERO
var distance

var atomic_density
var nu_bar = 1.0
var sigma_s_micro = 1.0
var sigma_c_micro = 0.0
var sigma_f_micro = 0.0
var sigma_total_micro = 1.0
var proba_s = 1.0
var proba_c = 0.0
var proba_f = 0.0

var limits = 10


func set_random_position():
	pass
	

func set_random_velocity():
	var radius = 5.0
	var theta = randf()*PI
	var phi = randf()*2*PI
	velocity.x = radius * sin(theta) * cos(phi)
	velocity.y = radius * sin(theta) * sin(phi)
	velocity.z = radius * cos(theta)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	set_random_velocity()

func rebound_on_walls():
	if (transform.origin.x > limits):
		velocity.x = - abs(velocity.x)
	elif (transform.origin.x < - limits):
		velocity.x = abs(velocity.x)
	
	if (transform.origin.y > 2*limits):
		velocity.y = - abs(velocity.y)
	elif (transform.origin.y < 0):
		velocity.y = abs(velocity.y)
	
	if (transform.origin.z > limits):
		velocity.z = - abs(velocity.z)
	elif (transform.origin.z < -limits):
		velocity.z = abs(velocity.z)

func delete_fled_neutron():
	if (abs(transform.origin.x) > limits):
		get_tree().get_current_scene().get_node("Control/Panel/VBoxContainer/minimal_VBoxContainer/nb_neutrons_label").update_nb_neutrons()
		get_parent().nb_neutrons -= 1
		queue_free()
	elif transform.origin.y > 2*limits or transform.origin.y < 0 :
		get_tree().get_current_scene().get_node("Control/Panel/VBoxContainer/minimal_VBoxContainer/nb_neutrons_label").update_nb_neutrons()
		get_parent().nb_neutrons -= 1
		queue_free()
	elif (abs(transform.origin.z) > limits):
		get_tree().get_current_scene().get_node("Control/Panel/VBoxContainer/minimal_VBoxContainer/nb_neutrons_label").update_nb_neutrons()
		get_parent().nb_neutrons -= 1
		queue_free()
	
func scatter():
	set_random_velocity()

func compute_probabilities():
	sigma_total_micro = sigma_s_micro + sigma_c_micro + sigma_f_micro
	proba_s = sigma_s_micro / sigma_total_micro
	proba_c = sigma_c_micro / sigma_total_micro
	proba_f = sigma_f_micro / sigma_total_micro

	
func compute_mean_free_path():
	var sigma_total_macro = atomic_density * sigma_total_micro * 1e-24
	var mean_free_path = 100 * (1 / sigma_total_macro)

func add_neutron():
	var neutron = neutron_scene.instance()
	#add_child(neutron)
	
	
func fission():
	var nb_generated_neutrons = 0
	var borne_inf = floor(nu_bar)
	if (borne_inf + randf() < nu_bar):
		nb_generated_neutrons = borne_inf
	else:
		nb_generated_neutrons = ceil(nu_bar) - 1
	
	get_parent().child_location = transform.origin
	for i in nb_generated_neutrons:
		get_parent().add_neutron()
		get_tree().get_current_scene().get_node("Control/Panel/VBoxContainer/minimal_VBoxContainer/nb_neutrons_label").update_nb_neutrons()
		
		
		
	
func compute_one_reaction():
	var alea = randf()
	#print("alea : ", alea)
	if (alea < proba_s):
		print("reaction : scatter")
		scatter()  
	elif (proba_s < alea && alea < proba_s + proba_c):
		print("reaction : capture")
		get_parent().nb_neutrons -= 1
		queue_free()
		#capture();    
	elif(proba_s + proba_c < alea && alea < 1.0):
		print("reaction : fission")
		#print("new neutron")
		fission()
		
		
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not(get_parent().on_pause):
		#timer += delta * time_multiplier
		distance = transform.origin.distance_squared_to(old_position)
		if in_a_volume and distance > mean_free_path:
			old_position = transform.origin
			compute_one_reaction()
		if get_parent().reflexions_activated:
			rebound_on_walls()
		else:
			delete_fled_neutron()
		#move_and_slide(velocity)
		move_and_collide(velocity*delta)


