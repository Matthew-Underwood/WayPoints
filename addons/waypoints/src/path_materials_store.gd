class_name MUW_Path_Materials_Store

var _path_materials = []

func _init(path_materials : Array):
	_path_materials = path_materials

func get_all() -> Array:
	return _path_materials
