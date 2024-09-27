extends MeshInstance

var _grid_lines = get_surface_material(0).get_next_pass().get_next_pass()
var _access_map_texture = get_surface_material(0).get_next_pass()
var _terrian_texture = get_surface_material(0)


func set_size(size : Vector2):
	_grid_lines.set_shader_param("map_size", size)
	_access_map_texture.set_shader_param("map_size", size)
	_terrian_texture.set_shader_param("map_size", size)


func refresh_mesh(array_mesh : ArrayMesh):
	for child in get_children():
		child.queue_free()
	mesh = array_mesh
	create_trimesh_collision()


func set_terrian_texture(terrian_texture):
	_terrian_texture.set_shader_param("terrian", terrian_texture)
	

func set_selection_pos(pos : Vector2):
	_access_map_texture.set_shader_param("cursor_pos", pos)


func set_selection_area(size : Vector2):
	_access_map_texture.set_shader_param("selection_area", size)


func set_access_texture_map(access_texture_map):
	_access_map_texture.set_shader_param("access_texture_map", access_texture_map)
	
