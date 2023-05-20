class_name MUP_Test_Pathing
extends GdUnitTestSuite

func test_add_cells():
	var obstacles = Vector2(5, 5)
	var a_star := mock(AStar) as AStar
	var world_a = mock(MUW_World)	
	var dimension = mock(MUP_Dimension_2D_Processor)
	do_return(Vector2(10, 10)).on(world_a).get_size()
	var pathing = _setup(a_star, world_a, dimension)
	pathing.add_walkable_cells([obstacles])
	verify(dimension, 0).point_to_position(Vector2(obstacles.x, obstacles.y))
	verify(dimension, 1).point_to_position(Vector2(1, 1))
	verify(dimension, 1).point_to_position(Vector2(7, 3))


func _setup(a_star, world, dimension):
	return MUP_Pathing.new(a_star, world, dimension)
