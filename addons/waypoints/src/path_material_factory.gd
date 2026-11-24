class_name MUW_Path_Material_Factory


func create(path_config : Dictionary) -> MUW_Path_Material:

	var texture_maps = {}
	var path_material = load("res://assets/materials/path_reference.tres")


	for layer_config in path_config.layers:

		var size = layer_config["size"]
		var id = layer_config["id"]
		var natural_id = id + 1
		var colour = layer_config["colour"]
		var path_size = layer_config["path_size"]
		var reference_map_size = layer_config["reference_map_size"]

		var texture_map = MUT_Texture_Map_Factory.new().create(reference_map_size)

		path_material.set_shader_param("path_colour" + str(natural_id), colour)
		path_material.set_shader_param("map_size" + str(natural_id), size)
		path_material.set_shader_param("reference_map_size" + str(natural_id), reference_map_size)
		path_material.set_shader_param("path_reference_map" + str(natural_id), texture_map.get_map())
		path_material.set_shader_param("path_size" + str(natural_id), path_size)

		texture_maps[id] = texture_map
	
	return MUW_Path_Material.new(path_material, texture_maps)
