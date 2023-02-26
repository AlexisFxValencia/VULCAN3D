# Licensed under the MIT License.
# Copyright (c) 2018-2020 Jaccomo Lorenz (Maujoe)

extends Control

# Constant Gui Settings
#*******************************************************************************
const GUI_POS = Vector2(10, 10)
const GUI_SIZE = Vector2(200, 0)
const DRAGGABLE = true

const CUSTOM_BACKGROUND = false
const BACKGROUND_COLOR = Color(0.15, 0.17, 0.23, 0.75) 

const MAX_SPEED = 50

var panel
var container
var mouse_over = false

var lbl_mouse
var source_button
var reflexions_button
var shutdown_button
var pause_button
var MFR_x_label 
var MFR_y_label 
var MFR_z_label 
var MFR_x_slider
var MFR_y_slider
var MFR_z_slider

var speed_label
var speed_slider

var b2m_label
var b2g_label
var b2g = 0

func _ready():
	# Create Gui
	panel = PanelContainer.new()

	panel.set_begin(GUI_POS)
	panel.set_custom_minimum_size(GUI_SIZE)
	add_child(panel)
	
	container = VBoxContainer.new()	
	panel.add_child(container)
	
	lbl_mouse = Label.new()
	lbl_mouse.set_text("Number of neutrons " + str(get_tree().current_scene.nb_neutrons))
	container.add_child(lbl_mouse)
	
	
	shutdown_button = Button.new()
	shutdown_button.text = "Close the program"
	shutdown_button.connect("pressed", self, "_shutdown")
	container.add_child(shutdown_button)
	
	
	source_button = Button.new()
	source_button.text = "Generate sources"
	source_button.connect("pressed", self, "generate_sources")
	container.add_child(source_button)
	
	
	reflexions_button = Button.new()
	reflexions_button.text = "Activate Reflexions"
	reflexions_button.connect("pressed", self, "_activate_reflexions")
	container.add_child(reflexions_button)

#	var captured_mouse_button = Button.new()
#	captured_mouse_button.text = "Capture mouse"
#	captured_mouse_button.connect("pressed", self, "_capture_mouse")
#	container.add_child(captured_mouse_button)
	
	pause_button = Button.new()
	pause_button.text = "Pause"
	pause_button.connect("pressed", self, "pause")
	container.add_child(pause_button)
	
	MFR_x_label = Label.new()
	MFR_x_label.set_text(" MFR x slider : ")
	container.add_child(MFR_x_label)
	
	MFR_x_slider = HScrollBar.new()
	MFR_x_slider.set_min(0.1)
	MFR_x_slider.set_max(5.0)
	MFR_x_slider.set_value(1.0)
	MFR_x_slider.connect("value_changed", self, "_set_MFR_x")
	container.add_child(MFR_x_slider)
	
	MFR_y_label = Label.new()
	MFR_y_label.set_text(" MFR y slider : ")
	container.add_child(MFR_y_label)
	
	MFR_y_slider = HScrollBar.new()
	MFR_y_slider.set_min(0.1)
	MFR_y_slider.set_max(5.0)
	MFR_y_slider.set_value(1.0)
	MFR_y_slider.connect("value_changed", self, "_set_MFR_y")
	container.add_child(MFR_y_slider)
	
	MFR_z_label = Label.new()
	MFR_z_label.set_text(" MFR z slider : ")
	container.add_child(MFR_z_label)
	
	MFR_z_slider = HScrollBar.new()
	MFR_z_slider.set_min(0.1)
	MFR_z_slider.set_max(5.0)
	MFR_z_slider.set_value(1.0)
	MFR_z_slider.connect("value_changed", self, "_set_MFR_z")
	container.add_child(MFR_z_slider)
	
	
	speed_label = Label.new()
	speed_label.set_text("Speed value : ")
	container.add_child(speed_label)
	
	speed_slider = HScrollBar.new()
	speed_slider.set_max(20.0)
	speed_slider.set_value(5.0)
	speed_slider.connect("value_changed", self, "change_gui_speed")
	container.add_child(speed_slider)
	
	b2m_label = Label.new()
	b2m_label.set_text("B2m = " + str(get_parent().get_node("Area").b2m))
	container.add_child(b2m_label)
	
	b2g_label = Label.new()
	_compute_b2g()
	b2g_label.set_text("B2g = " + str(b2g))
	container.add_child(b2g_label)
	
	if DRAGGABLE:
		panel.connect("mouse_entered", self, "_panel_entered")
		panel.connect("mouse_exited", self, "_panel_exited")
		container.connect("mouse_entered", self, "_panel_entered")
		container.connect("mouse_exited", self, "_panel_exited")
		for child in container.get_children():
			child.connect("mouse_entered", self, "_panel_entered")
			child.connect("mouse_exited", self, "_panel_exited")
			
		
	#self.hide()
	
	
func _compute_b2g():
	var vector = get_parent().get_node("Area/CollisionShape").shape.extents
	b2g = pow(PI/vector.x,2) + pow(PI/vector.y,2) + pow(PI/vector.z,2)

	
func _set_MFR_x(val):
	get_parent().get_node("Area/CollisionShape").shape.extents.x = 2*val
	get_parent().get_node("Area/MFR").mesh.size.x = 4*val
	_compute_b2g()
	b2g_label.set_text("B2g = " + str(b2g))
	
func _set_MFR_y(val):
	get_parent().get_node("Area/CollisionShape").shape.extents.y = 2*val
	get_parent().get_node("Area/MFR").mesh.size.y = 4*val
	_compute_b2g()
	b2g_label.set_text("B2g = " + str(b2g))
	
func _set_MFR_z(val):
	get_parent().get_node("Area/CollisionShape").shape.extents.z = 2*val
	get_parent().get_node("Area/MFR").mesh.size.z = 4*val
	_compute_b2g()
	b2g_label.set_text("B2g = " + str(b2g))
	
func change_gui_speed(val):
	print("changing speed")
	get_parent().get_node("Camera").max_speed.x = val
	get_parent().get_node("Camera").max_speed.y = val
	get_parent().get_node("Camera").max_speed.z = val
	

func _shutdown():
	print("_shutdown")
	get_tree().quit()

func generate_sources():
	for i in get_parent().NB_NEUTRONS_INIT:
		get_parent().add_neutron()

func _activate_reflexions():
	if get_parent().reflexions_activated:
		get_parent().reflexions_activated = false
		reflexions_button.text = "Activate Reflexions"
	else:
		get_parent().reflexions_activated = true
		reflexions_button.text = "Deactivate Reflexions"



func _capture_mouse():
	if get_parent().get_node("Camera").freelook == false:
		get_parent().get_node("Camera").freelook = true
	else:
		get_parent().get_node("Camera").freelook = false
	
	
func update_nb_neutrons():
	var text = "Number of neutrons " + str(get_parent().nb_neutrons)
	lbl_mouse.set_text(text)

func pause():
	if get_parent().on_pause:
		get_parent().on_pause = false
		pause_button.text = "Pause"
	else:
		get_parent().on_pause = true
		pause_button.text = "Play"


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

	if event is InputEventMouseButton and event.pressed :
		if not(mouse_over):
			if Input.is_action_pressed("ui_capture_mouse"):
				_capture_mouse()



func _panel_entered():
	mouse_over = true
	#print("mouse_over is : ", mouse_over)

func _panel_exited():
	mouse_over = false
	#print("mouse_over is : ", mouse_over)
