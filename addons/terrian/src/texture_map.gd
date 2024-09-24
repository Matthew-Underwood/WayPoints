class_name MUT_Texture_Map

var _texture : ImageTexture

func _init(texture : ImageTexture):
	_texture = texture

func update(pos : Vector2, colour : Vector3):

	var image = _texture.get_data()
	image.lock()
	image.set_pixelv(pos, Color8(colour.x, colour.y, colour.z))
	image.unlock()
	#image.save_png("test.png")
	_texture.create_from_image(image, 0)


func get_map() -> ImageTexture:
	return _texture
