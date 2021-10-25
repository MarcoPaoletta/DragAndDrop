extends Area2D

var selected : bool = false

func _ready():
	get_tree().set_auto_accept_quit(false)
	OS.center_window()
	g.load_data()
	global_position = g["game"]["spr_pos"] 
	modulate = g["game"]["spr_color"]
	check_animation()
	
func _process(delta):
	if selected:
		position = get_global_mouse_position()
		g["game"]["spr_pos"] = global_position
	g.save_data()
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		g.save_data() 

func _on_Player_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			selected = true
		else:
			selected = false
	
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		
		match event.button_index:
			
			BUTTON_WHEEL_UP:
				check_animation_and_invert_var()		
				
			BUTTON_WHEEL_DOWN:
				check_animation_and_invert_var()
				
func check_animation_and_invert_var():
	g["game"]["spr_skin"] = !g["game"]["spr_skin"]
	check_animation()

func check_animation():
	match g["game"]["spr_skin"]:
		
		true:
			$Sprite.animation = "skin_2"
		
		false:
			$Sprite.animation = "skin_1"
