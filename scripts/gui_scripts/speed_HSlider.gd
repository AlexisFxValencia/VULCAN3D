extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
		connect("value_changed", self, "change_speed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func change_speed(val):
	print("changing speed")
	get_tree().get_current_scene().get_node("Camera").max_speed.x = val
	get_tree().get_current_scene().get_node("Camera").max_speed.y = val
	get_tree().get_current_scene().get_node("Camera").max_speed.z = val
	
