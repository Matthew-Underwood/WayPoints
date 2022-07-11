class_name MUP_Test_World
extends GdUnitTestSuite

var _size = Vector2(10, 10)
var _unwalkable_points = [Vector2(1, 1)]


func test_get_size():
	var transformer = mock(MUP_World_Transformers_Screen_Tilemap)
	var world = _setup(_size, _unwalkable_points, transformer)
	assert_vector2(_size).is_equal(world.get_size())	


func test_out_of_bounds():
	var transformer = mock(MUP_World_Transformers_Screen_Tilemap)
	var world = _setup(_size, _unwalkable_points, transformer)
	var world_positions = [Vector2(21 , 2), Vector2(2, 21), Vector2(-1, -2), Vector2(11, 11)]
	for p in world_positions:
		var out_of_bounds = world.is_out_of_bounds(p)
		assert_bool(out_of_bounds).is_true()


func test_in_bounds():
	var transformer = mock(MUP_World_Transformers_Screen_Tilemap)
	var world = _setup(_size, _unwalkable_points, transformer)
	var world_positions = [Vector2.ONE, _size - Vector2.ONE]
	for p in world_positions:
		var in_bounds = world.is_out_of_bounds(p)
		assert_bool(in_bounds).is_false()
		

func test_not_walkable():
	var screen_pos = Vector2(80, 80)
	var transformer = mock(MUP_World_Transformers_Screen_Tilemap)
	
	do_return(Vector3(1, 1, 0)).on(transformer).transform(screen_pos)

	var world = _setup(_size, _unwalkable_points, transformer)
	var is_not_walkable = world.is_walkable(screen_pos)
	
	assert_bool(is_not_walkable).is_false()	
	

func test_walkable():
	var screen_pos = Vector2(10, 10)
	var transformer = mock(MUP_World_Transformers_Screen_Tilemap)
	
	do_return(Vector3(0, 0, 0)).on(transformer).transform(screen_pos)

	var world = _setup(_size, _unwalkable_points, transformer)
	var is_walkable = world.is_walkable(screen_pos)
	
	assert_bool(is_walkable).is_true()


func _setup(size, unwalkable_points, transformer):
	return MUP_World.new(size, unwalkable_points, transformer)
