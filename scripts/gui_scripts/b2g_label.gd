extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_b2g()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_b2g():
	get_tree().get_current_scene().get_node("Area").compute_b2g()
	set_text("B2g = " + str(get_tree().get_current_scene().get_node("Area").b2g))
