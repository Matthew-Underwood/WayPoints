extends Camera

var move_speed = 10
var rotation_speed = 0.1
var mouse_start = Vector2.ZERO
var mouse_current = Vector2.ZERO
var _screen_center : Vector2

func _ready():
	_screen_center = get_viewport().size / 2

func _process(delta):
	var translation = Vector3.ZERO
	if Input.is_action_pressed("ui_right"):
		translation.x += move_speed * delta
	if Input.is_action_pressed("ui_left"):
		translation.x -= move_speed * delta
	if Input.is_action_pressed("ui_up"):
		translation.z += move_speed * delta
	if Input.is_action_pressed("ui_down"):
		translation.z -= move_speed * delta
	
	translate(translation)


func _input(event):
	var projection_pos = project_position(_screen_center, 0)
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		mouse_start = event.position
	elif event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			mouse_current = event.position
			var delta = mouse_current - mouse_start
			rotate_object_local(transform.basis.y, delta.x * rotation_speed)
			mouse_start = mouse_current
	
