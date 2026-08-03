class_name MUW_Path_Material

var _material
var _texture_maps

func _init(material : ShaderMaterial, texture_maps : Dictionary):

	_material = material
	_texture_maps = texture_maps


func update_map(pos : Vector2, colour : Vector3, layer : int):

	_texture_maps[layer].update(pos, colour)


func get_material() -> ShaderMaterial:

	return _material


func update_material(layer : int):

	var map = _texture_maps[layer]
	var natural_layer = layer + 1
	_material.set_shader_param("path_reference_map" + str(natural_layer), map.get_map())



