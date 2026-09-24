class_name MUW_Transformers_Path

var _config : Array

func _init(config : Array):
	_config = config


func transform(pos : Vector2, layer : int):

	var resolution = Vector2(10, 10) / _config[layer].size
	var translated_pos = pos / resolution
	print("translated pos" + str(translated_pos.floor()))
	return translated_pos.floor()
