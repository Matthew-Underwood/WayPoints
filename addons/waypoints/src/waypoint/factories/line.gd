class_name MUW_Factory_Line


func create(point_pos : Vector3, point_pos2 : Vector3, waypoint_pos : Vector3):
    var line = load("res://addons/waypoints/scenes/spatial/line.tscn")
    line = line.instance()
    line.set_point_positions(point_pos, point_pos2)
    line.set_waypoint_position(waypoint_pos)
    return line