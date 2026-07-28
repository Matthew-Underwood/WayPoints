class_name MUW_Path

var _material
var _id
var _texture_map

func _init(material : ShaderMaterial, texture_map : MUT_Texture_Map, id : int):

	_material = material
	_texture_map = texture_map
	_id = id 


func update_map(pos : Vector2, colour : Vector3):

	_texture_map.update(pos, colour)


func get_material() -> ShaderMaterial:

	return _material


func update_material():

	_material.set_shader_param("bezier_path_map", _texture_map.get_map())


func get_id() -> int:

	return _id
