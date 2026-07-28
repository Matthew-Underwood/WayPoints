class_name MUW_Path_Factory

func create(size : Vector2, id : int) -> MUW_Path:

	var texture_map = MUT_Texture_Map_Factory.new().create(size)
	var material = load("res://assets/material/path.tres")
	material.set_shader_param("map_size", size)
	material.set_shader_param("bezier_path_map", texture_map.get_map())
	var path = MUW_Path.new(material, texture_map, id)
	return path

