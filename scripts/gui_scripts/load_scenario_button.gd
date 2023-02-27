extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "load_scenario")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func load_scenario():
	var item = get_parent().get_node("Tree").get_selected().get_text(0)
	print("load scenario...", item)
	get_tree().change_scene("res://scenes/poison.tscn")
