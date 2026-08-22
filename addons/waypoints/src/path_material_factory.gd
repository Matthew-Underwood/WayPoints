class_name MUW_Path_Material_Factory


func create(path_config : Array) -> MUW_Path_Material:

	var texture_maps = {}
	var path_material = load("res://assets/materials/path_reference.tres")

	for config in path_config:

		var size = config["size"]
		var id = config["id"]
		var natural_id = id + 1
		var colour = config["colour"]

		var texture_map = MUT_Texture_Map_Factory.new().create(size)

		path_material.set_shader_param("path_colour" + str(natural_id), colour)
		path_material.set_shader_param("map_size" + str(natural_id), size)
		path_material.set_shader_param("path_reference_map" + str(natural_id), texture_map.get_map())

		texture_maps[id] = texture_map
	
	return MUW_Path_Material.new(path_material, texture_maps)
