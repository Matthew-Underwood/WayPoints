class_name MUW_Resolver_Height

var _height_data : Dictionary

func _init(height_data : Dictionary):
    _height_data = height_data

func resolve(pos : Vector2):
    if _height_data.has(pos):
        return _height_data[pos]
    return null
