class_name MUW_Path

func _init(material : ShaderMaterial, texture_map : MUW_Texture_Map)
	_material = material
	_texture_map = texture_map

func update_map(pos : Vector2, colour : Vector3):

	_texture_map.update(pos, colour)
