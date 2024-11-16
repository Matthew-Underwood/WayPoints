class_name MUW_Path_Structure

var _waypoint_data: Array
var _map: MUT_Texture_Map
var _directions : Dictionary
var _mask

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
            var rgb_code = 0 
            var direction_id = _directions[pos]["direction_id"]
            rgb_code = direction_id
            _map.update(pos, rgb_code)
    _mask.set_shader_param("map", _map.get_map())
   

func _normalise_position(pos : Vector3):

    return Vector2(pos.x, pos.z).floor()


func _set_direction(pos : Vector2, relative_positions : Dictionary):

    if !_directions.has(pos):
        _directions[pos] = {"direction_id" : 0}
    var direction_id = _get_direction_id(relative_positions)
    _directions[pos]["direction_id"] += direction_id


func _get_id_from_relative_pos(relative_directions : Dictionary):

    var id = 0
    match relative_directions:
        #linear half line
        {"next" : Vector2(1, 0)}:
            id = 1
        {"next" : Vector2(1, 1)}:
            id = 2
        {"next" : Vector2(0, 1)}:
            id = 4
        {"next" : Vector2(-1, 1)}:
            id = 8
        {"next" : Vector2(-1, 0)}:
            id = 16
        {"next" : Vector2(-1, -1)}:
            id = 32
        {"next" : Vector2(0, -1)}:
            id = 64
        {"next" : Vector2(1, -1)}:
            id = 128
        # linear full line
        {"previous" : Vector2(-1, 0), "next" : Vector2(1, 0)}:
            id = 1
        {"previous" : Vector2(-1, -1), "next" : Vector2(1, 1)}:
            id = 2
        {"previous" : Vector2(0, -1), "next" : Vector2(0, 1)}:
            id = 4
        {"previous" : Vector2(1, -1), "next" : Vector2(-1, 1)}:
            id = 8
        {"previous" : Vector2(1, 0), "next" : Vector2(-1, 0)}:
            id = 16
        {"previous" : Vector2(1, 1), "next" : Vector2(-1, -1)}:
            id = 32
        {"previous" : Vector2(0, 1), "next" : Vector2(0, -1)}:
            id = 64
        {"previous" : Vector2(-1, 1), "next" : Vector2(1, -1)}:
            id = 128
        # bezier curve
        {"previous" : Vector2(-1, 0), "next" : Vector2(1, 1)}:
            id = 1
        {"previous" : Vector2(0, -1), "next" : Vector2(-1, 1)}:
            id = 2
        {"previous" : Vector2(1, 0), "next" : Vector2(-1, -1)}:
            id = 4
        {"previous" : Vector2(0, 1), "next" : Vector2(1, -1)}:
            id = 8
        {"previous" : Vector2(-1, 0), "next" : Vector2(1, -1)}:
            id = 16
        {"previous" : Vector2(0, -1), "next" : Vector2(1, 1)}:
            id = 32
        {"previous" : Vector2(1, 0), "next" : Vector2(-1, 1)}:
            id = 64
        {"previous" : Vector2(0, 1), "next" : Vector2(-1, -1)}:
            id = 128
        # bezier curve
        {"previous" : Vector2(0, 1), "next" : Vector2(1, 0)}:
            id = 1
        {"previous" : Vector2(-1, 0), "next" : Vector2(0, 1)}:
            id = 2
        {"previous" : Vector2(0, -1), "next" : Vector2(-1, 0)}:
            id = 4
        {"previous" : Vector2(1, 0), "next" : Vector2(0, -1)}:
            id = 8
        {"previous" : Vector2(0, -1), "next" : Vector2(1, 0)}:
            id = 16
        {"previous" : Vector2(1, 0), "next" : Vector2(0, 1)}:
            id = 32
        {"previous" : Vector2(0, 1), "next" : Vector2(-1, 0)}:
            id = 64
        {"previous" : Vector2(-1, 0), "next" : Vector2(0, -1)}:
            id = 128
        #bezier curve
        {"previous" : Vector2(1, -1), "next" : Vector2(1, 1)}:
            id = 1
        {"previous" : Vector2(1, 1), "next" : Vector2(-1, 1)}:
            id = 2
        {"previous" : Vector2(-1, 1), "next" : Vector2(-1, -1)}:
            id = 4
        {"previous" : Vector2(-1, -1), "next" : Vector2(1, -1)}:
            id = 8
        {"previous" : Vector2(-1, -1), "next" : Vector2(1, -1)}:
            id = 16
    return id
       

func _get_direction_id(relative_directions : Dictionary):

    var id = 0

    match relative_directions:
        {"previous" : Vector2(0, 0), "next" : Vector2(1, 0)}:
            id = 1
        {"previous" : Vector2(0, 0), "next" : Vector2(1, 1)}:
            id = 2
        {"previous" : Vector2(0, 0), "next" : Vector2(0, 1)}:
            id = 4
        {"previous" : Vector2(0, 0), "next" : Vector2(-1, 1)}:
            id = 8
        {"previous" : Vector2(0, 0), "next" : Vector2(-1, 0)}:
            id = 16
        {"previous" : Vector2(0, 0), "next" : Vector2(-1, -1)}:
            id = 32
        {"previous" : Vector2(0, 0), "next" : Vector2(0, -1)}:
            id = 64
        {"previous" : Vector2(0, 0), "next" : Vector2(0, -1)}:
            id = 128
    return id
       

func _get_direction_id(relative_directions : Dictionary):

    var id = 0

    match relative_directions:
        {"previous" : Vector2(0, 0), "next" : Vector2(1, 0)}:
            id = 1
        {"previous" : Vector2(0, 0), "next" : Vector2(1, 1)}:
            id = 2
        {"previous" : Vector2(0, 0), "next" : Vector2(0, 1)}:
            id = 4
        {"previous" : Vector2(0, 0), "next" : Vector2(-1, 1)}:
            id = 8
        {"previous" : Vector2(0, 0), "next" : Vector2(-1, 0)}:
            id = 16
        {"previous" : Vector2(0, 0), "next" : Vector2(-1, -1)}:
            id = 32
        {"previous" : Vector2(0, 0), "next" : Vector2(0, -1)}:
            id = 64
        {"previous" : Vector2(0, 0), "next" : Vector2(0, -1)}:
            id = 128
    return id
            

func _get_relative_position(pos1 : Vector2, pos2 : Vector2):

    return  pos1 - pos2
    
