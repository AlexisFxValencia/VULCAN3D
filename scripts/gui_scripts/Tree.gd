extends Tree


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var root = create_item()
	#set_hide_root(true)
	root.set_text(0, "Scenarios")
	var child1 = create_item(root)
	child1.set_text(0, "mass")
	child1.select(0)
	var child2 = create_item(root)
	child2.set_text(0, "reflexions")
	var child3 = create_item(root)
	child3.set_text(0, "poison")
	#var subchild1 = create_item(child1)
	#subchild1.set_text(0, "reflexions")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
