class_name MUW_Path_Directions_Store_Factory

func create(config : Array) -> MUW_Path_Directions_Store: 

	var transformer = MUW_Transformers_Path.new(config)
	return MUW_Path_Directions_Store.new(transformer)
