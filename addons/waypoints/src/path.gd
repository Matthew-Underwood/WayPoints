class_name MUW_Path

func _init(material : ShaderMaterial, texture_map : MUW_Texture_Map)
	_material = material
	_texture_map = texture_map

func update_map(pos : Vector2, colour : Vector3):

	_texture_map.update(pos, colour)

func get_material():

	return _material

func update_material():

	_material.set_shader_param("bezier_path_map", _texture_map.get_map())
