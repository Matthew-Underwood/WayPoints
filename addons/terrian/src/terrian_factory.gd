class_name MUT_Terrian_Factory

var _map_processor : MUT_Basic_Texture_Map_Processor

func _init(map_processor : MUT_Basic_Texture_Map_Processor):
	_map_processor = map_processor


func create(size : Vector2, terrian_texture, inaccessable_positions = []):

	_map_processor.create(size)
	if !inaccessable_positions.empty():
		_map_processor.update(inaccessable_positions, 1);

	var terrian = load("res://addons/terrian/assets/scene/terrian.tscn")
	terrian = terrian.instance()
	terrian.set_size(size)
	terrian.set_selection_pos(size * 0.5)
	terrian.set_selection_area(Vector2(3, 3))
	terrian.set_access_texture_map(_map_processor.get_texture_map())
	terrian.set_terrian_texture(terrian_texture)
	return terrian

