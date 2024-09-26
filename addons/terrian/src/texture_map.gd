class_name MUT_Basic_Texture_Map

const DEFAULT_LEVEL = Color(0, 0, 0, 1)

var _levels = [DEFAULT_LEVEL, Color(1, 1, 1, 1)]

func apply(level : int) -> Color:
	if level == 0 || level == 1:
		return _levels[level]
	return _levels[0]
