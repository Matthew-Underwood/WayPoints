class_name MUT_Texture_Map

var _texture : ImageTexture

func _init(texture : ImageTexture):
	_texture = texture

func update(pos : Vector2, id : int):

	var image = _texture.get_data()
	image.lock()
	image.set_pixelv(pos, Color8(id, id, id))
	image.unlock()
	#image.save_png("test.png")
	_texture.create_from_image(image, 0)


func get_map() -> ImageTexture:
	return _texture
