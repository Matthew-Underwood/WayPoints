class_name MUT_Terrian_Factory

var _texture_map_factory : MUT_Texture_Map_Factory

func _init(texture_map_factory : MUT_Texture_Map_Factory):
	_texture_map_factory = texture_map_factory


func create(size : Vector2, terrian_texture, inaccessable_positions = []):

	var texture_map = _texture_map_factory.create(size)

	if !inaccessable_positions.empty():
		for vec in inaccessable_positions:
			texture_map.update(vec, Vector3(255, 255, 255));

	var terrian = load("res://assets/scene/terrian.tscn")
	terrian = terrian.instance()
	terrian.set_size(size)
	terrian.set_selection_pos(size * 0.5)
	terrian.set_selection_area(Vector2(3, 3))
	terrian.set_access_texture_map(texture_map.get_map())
	terrian.set_terrian_texture(terrian_texture)
	return terrian

