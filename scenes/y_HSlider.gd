extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("value_changed", self, "_set_y_size")

func _set_y_size(val):
	get_tree().get_current_scene().get_node("Area/CollisionShape").shape.extents.y = 2*val
	get_tree().get_current_scene().get_node("Area/MFR").mesh.size.y = 4*val
	get_parent().get_node("b2g_label").update_b2g()
