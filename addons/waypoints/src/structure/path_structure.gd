class_name MUW_Path_Structure

var _waypoint_data: Array
var _map: MUT_Texture_Map
var _directions : Dictionary
var _mask

#TODO make a multiple texture map
func _init(map : MUT_Texture_Map, mask):
	_map = map
	_mask = mask

func create(waypoint_data: MUW_Waypoint_Data):
	_waypoint_data.append(waypoint_data)
	_set_path()


func update(id: int, waypoint_data: MUW_Waypoint_Data):
	_waypoint_data[id] = waypoint_data
	_set_path()


func remove(id: int):
	_waypoint_data.remove(id)
	_set_path()


func _set_path():
    
    if !_waypoint_data.empty():
        for waypoint_data in _waypoint_data:
            var points = waypoint_data.get_path()
            for id in range(points.size()):
                var relative_directions = {"previous" : Vector2(0, 0), "next" : Vector2(0, 0)}
                var previous_id = id - 1
                var next_id = id + 1
                var current_position = _normalise_position(points[id]) 

                if previous_id >= 0:
                    var previous_position = _normalise_position(points[previous_id])
                    relative_directions["previous"] = _get_relative_position(previous_position, current_position)

                if next_id < points.size():
                    var next_position = _normalise_position(points[next_id])
                    relative_directions["next"] = _get_relative_position(next_position, current_position)
                _set_direction(current_position, relative_directions)
        
        for pos in _directions:
            _map.update(pos, _directions[pos]["linear_ids"])
            _map.update(pos, _directions[pos]["bezier_ids"])
            _map.update(pos, rgb_code)
    _mask.set_shader_param("map", _map.get_map())
   

func _normalise_position(pos : Vector3):

    return Vector2(pos.x, pos.z).floor()


func _set_direction(pos : Vector2, relative_positions : Dictionary):

    if !_directions.has(pos):
        _directions[pos] = {"linear_ids" : Vector3(0, 0, 0), "bezier_ids" : Vector3(0, 0, 0)}

    var linear_half_id = _get_id_linear_half_line(relative_positions)
    var linear_id = _get_id_linear_line(relative_positions)
    var bezier_obtuse_id = _get_id_bezier_obtuse(relative_positions)
    var bezier_right_angle_id = _get_id_bezier_right_angle(relative_positions)

    _directions[pos]["linear_ids"].x += linear_half_id
    _directions[pos]["linear_ids"].y += linear_id
    _directions[pos]["bezier_ids"].x += bezier_obtuse_id
    _directions[pos]["bezier_ids"].y += bezier_right_angle_id


func _get_id_linear_half_line(relative_pos : Dictionary):

    match relative_pos
        #linear half line
        {"next" : Vector2(1, 0)}, {"previous" : Vector2(1, 0)}:
            id = 1
        {"next" : Vector2(1, 1)}, {"previous" : Vector2(1, 1)}:
            id = 2
        {"next" : Vector2(0, 1)}, {"previous" : Vector2(0, 1)}:
            id = 4
        {"next" : Vector2(-1, 1)}, {"previous" : Vector2(-1, 1)}:
            id = 8
        {"next" : Vector2(-1, 0)}, {"previous" : Vector2(-1, 0)}:
            id = 16
        {"next" : Vector2(-1, -1)}, {"previous" : Vector2(-1, -1)}:
            id = 32
        {"next" : Vector2(0, -1)}, {"previous" : Vector2(0, -1)}:
            id = 64
        {"next" : Vector2(1, -1)}, {"previous" : Vector2(1, -1)}:
            id = 128

    return id


func _get_id_linear_line(relative_pos : Dictionary):

    match relative_pos
        # linear full line
        {"previous" : Vector2(-1, 0), "next" : Vector2(1, 0)}, {"next" : Vector2(-1, 0), "previous" : Vector2(1, 0)}:
            id = 1
        {"previous" : Vector2(-1, -1), "next" : Vector2(1, 1)}, {"next" : Vector2(-1, -1), "previous" : Vector2(1, 1)}:
            id = 2
        {"previous" : Vector2(0, -1), "next" : Vector2(0, 1)}, {"next" : Vector2(0, -1), "previous" : Vector2(0, 1)}:
            id = 4
        {"previous" : Vector2(1, -1), "next" : Vector2(-1, 1)}, {"next" : Vector2(1, -1), "previous" : Vector2(-1, 1)}:
            id = 8

     return id


func _get_id_bezier_obtuse(relative_pos : Dictionary):

    match relative_pos
        # bezier slight curve
        {"previous" : Vector2(-1, 0), "next" : Vector2(1, 1)}, {"next" : Vector2(-1, 0), "previous" : Vector2(1, 1)}:
            id = 1
        {"previous" : Vector2(0, -1), "next" : Vector2(-1, 1)}, {"next" : Vector2(0, -1), "previous" : Vector2(-1, 1)}:
            id = 2
        {"previous" : Vector2(1, 0), "next" : Vector2(-1, -1)}, {"next" : Vector2(1, 0), "previous" : Vector2(-1, -1)}:
            id = 4
        {"previous" : Vector2(0, 1), "next" : Vector2(1, -1)}, {"next" : Vector2(0, 1), "previous" : Vector2(1, -1)}:
            id = 8
        {"previous" : Vector2(-1, 0), "next" : Vector2(1, -1)}, {"next" : Vector2(-1, 0), "previous" : Vector2(1, -1)}:
            id = 16
        {"previous" : Vector2(0, -1), "next" : Vector2(1, 1)}, {"next" : Vector2(0, -1), "previous" : Vector2(1, 1)}:
            id = 32
        {"previous" : Vector2(1, 0), "next" : Vector2(-1, 1)}, {"next" : Vector2(1, 0), "previous" : Vector2(-1, 1)}:
            id = 64
        {"previous" : Vector2(0, 1), "next" : Vector2(-1, -1)}, {"next" : Vector2(0, 1), "previous" : Vector2(-1, -1)}:
            id = 128

    return id


func _get_id_bezier_right_angle(relative_pos : Dictionary):

    match relative_pos
        # bezier sharp curve
        {"previous" : Vector2(0, 1), "next" : Vector2(1, 0)}, {"next" : Vector2(0, 1), "previous" : Vector2(1, 0)}:
            id = 1
        {"previous" : Vector2(-1, 0), "next" : Vector2(0, 1)}, {"next" : Vector2(-1, 0), "previous" : Vector2(0, 1)}:
            id = 2
        {"previous" : Vector2(0, -1), "next" : Vector2(-1, 0)}, {"next" : Vector2(0, -1), "previous" : Vector2(-1, 0)}:
            id = 4
        {"previous" : Vector2(1, 0), "next" : Vector2(0, -1)}, {"next" : Vector2(1, 0), "previous" : Vector2(0, -1)}:
            id = 8
        {"previous" : Vector2(1, -1), "next" : Vector2(1, 1)}, {"next" : Vector2(1, -1), "previous" : Vector2(1, 1)}:
            id = 16
        {"previous" : Vector2(1, 1), "next" : Vector2(-1, 1)}, {"next" : Vector2(1, 1), "previous" : Vector2(-1, 1)}:
            id = 32
        {"previous" : Vector2(-1, 1), "next" : Vector2(-1, -1)}, {"next" : Vector2(-1, 1), "previous" : Vector2(-1, -1)}:
            id = 64
        {"previous" : Vector2(-1, -1), "next" : Vector2(1, -1)}, {"previous" : Vector2(-1, -1), "next" : Vector2(1, -1)}:
            id = 128

    return id 
      

func _get_relative_position(pos1 : Vector2, pos2 : Vector2):

    return  pos1 - pos2
    
