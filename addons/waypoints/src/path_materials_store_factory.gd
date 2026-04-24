class_name MUW_Path_Materials_Store_Factory

var _path_factory

func _init(path_factory : MUW_Path_Factory):
	_path_factory = path_factory 

func create(path_config : Array) -> MUW_Path_Materials_Store:

	var paths = []
	for config in path_config:
		paths.append(_path_factory.create(config["size"]))
	
	return MUW_Path_Materials_Store.new(paths)

		
		

