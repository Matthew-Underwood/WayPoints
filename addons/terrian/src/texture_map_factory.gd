class_name MUT_Texture_Map_Factory

func create(size : Vector2) -> MUT_Texture_Map:

	var texture = ImageTexture.new()
	var image = Image.new()
	image.create(size.x, size.y, false, Image.FORMAT_RGB8)
	image.fill(Color(0, 0, 0))
	texture.create_from_image(image)
	return MUT_Texture_Map.new(texture)