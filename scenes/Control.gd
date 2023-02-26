extends Control

var mouse_over = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("mouse_entered", self, "_panel_entered")
	connect("mouse_exited", self, "_panel_exited")
	connect_all_gui_nodes(get_child(0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func connect_all_gui_nodes(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			#print("["+N.get_name()+"]")
			connect_all_gui_nodes(N)
		else:
			N.connect("mouse_entered", self, "_panel_entered")
			N.connect("mouse_exited", self, "_panel_exited")
			#print("- "+N.get_name())
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

	if event is InputEventMouseButton and event.pressed :
		if not(mouse_over):
			if Input.is_action_pressed("ui_capture_mouse"):
				_capture_mouse()

func _capture_mouse():
	if get_parent().get_node("Camera").freelook == false:
		get_parent().get_node("Camera").freelook = true
	else:
		get_parent().get_node("Camera").freelook = false
	
	
func _panel_entered():
	mouse_over = true
	#print("mouse_over is : ", mouse_over)

func _panel_exited():
	mouse_over = false
	#print("mouse_over is : ", mouse_over)
