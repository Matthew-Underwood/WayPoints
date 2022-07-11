class_name MUP_Test_Pathing
extends GdUnitTestSuite

func test_add_cells():
	var obstacles = Vector2(5, 5)
	var a_star := mock(AStar) as AStar
	var world_a = mock(MUP_World)	
	do_return(Vector2(10, 10)).on(world_a).get_size()
	var pathing = _setup(a_star, world_a)
	pathing.add_walkable_cells([obstacles])
	verify(a_star, 0).add_point(any_float(), Vector3(obstacles.x, obstacles.y, 0))
	verify(a_star, 1).add_point(any_float(), Vector3(1, 1, 0))
	verify(a_star, 1).add_point(any_float(), Vector3(7, 3, 0))


func _setup(a_star, world):
	return MUP_Pathing.new(a_star, world)
