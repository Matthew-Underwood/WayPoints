class_name MUT_Basic_Texture_Map_Processor

var _image : Image
var _texture_map : MUT_Basic_Texture_Map


func _init(texture_map : MUT_Basic_Texture_Map):
	_texture_map = texture_map


func create(size : Vector2) -> void:
	_image = Image.new()
	_image.create(size.x, size.y, false, Image.FORMAT_RGB8)
	_image.fill(_texture_map.DEFAULT_LEVEL)


func update(vectors : Array, value : int) -> void:

	_image.lock()
	for v in vectors:
		_image.set_pixelv(v, _texture_map.apply(value))
	_image.unlock()


func get_texture_map() -> ImageTexture:
	var texture = ImageTexture.new()
	texture.create_from_image(_image)
	return texture