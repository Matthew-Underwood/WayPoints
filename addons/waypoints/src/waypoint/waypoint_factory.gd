class_name MUW_Waypoint_Factory


func create(id : int, points : Array, world_position : Vector2) -> MUW_WayPoint:

	return MUW_WayPoint.new(id, points, world_position)