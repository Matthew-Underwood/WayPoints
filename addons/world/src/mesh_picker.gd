class_name MUW_Mesh_Picker

var _camera : Camera
var _world : World


func _init(camera : Camera, world : World):
	_camera = camera
	_world = world


func pick(pos : Vector2) -> Dictionary:
	var from = _camera.project_ray_origin(pos)
	var to = from + _camera.project_ray_normal(pos) * 1000
	return _world.direct_space_state.intersect_ray(from, to)
