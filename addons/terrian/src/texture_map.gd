class_name MUT_Texture_Map

var _texture : ImageTexture
var _size : Vector2

func _init(texture : ImageTexture, size : Vector2):

	_texture = texture
	_size = size


func clear():

	var image = _texture.get_data()
	image.lock()
	for y in range(_size.y):
		for x in range(_size.x):
			var pos = Vector2(x, y)
			image.set_pixelv(pos, Color8(0, 0, 0))
	image.unlock()
	_texture.create_from_image(image, 0)


func update(pos : Vector2, colour : Vector3):

	var image = _texture.get_data()
	image.lock()
	image.set_pixelv(pos, Color8(colour.x, colour.y, colour.z))
	image.unlock()
	_texture.create_from_image(image, 0)


func get_map() -> ImageTexture:
	return _texture
