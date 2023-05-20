extends Spatial

var move_speed = 10
var rotation_speed = 0.1
var mouse_start = Vector2.ZERO
var mouse_current = Vector2.ZERO


func _process(delta):
	var translation = Vector3.ZERO
	if Input.is_action_pressed("ui_right"):
		translation.x += move_speed * delta
	if Input.is_action_pressed("ui_left"):
		translation.x -= move_speed * delta
	if Input.is_action_pressed("ui_up"):
		translation.z -= move_speed * delta
	if Input.is_action_pressed("ui_down"):
		translation.z += move_speed * delta
	
	translate(translation)


func _input(event):
	if event is InputEventKey and event.pressed and Input.is_action_pressed("rotate"):
		mouse_start = get_viewport().get_mouse_position()
	elif event is InputEventMouseMotion:
		if Input.is_action_pressed("rotate"):
			mouse_current = event.position
			var delta = mouse_current - mouse_start
			rotate_object_local(transform.basis.y, delta.x * rotation_speed)
			mouse_start = mouse_current
	
