class_name MUW_Multi_Node

var _waypoints : MUW_WayPoints
var _world : MUW_World
var _waypoint_node_factory : MUW_WayPoint_Node_Factory
var _waypoint_nodes : Array


func _init(world : MUW_World, waypoints : MUW_WayPoints, waypoint_node_factory : MUW_WayPoint_Node_Factory):
    _waypoints = waypoints
    _world = world
    _waypoint_node_factory = waypoint_node_factory


func create(pos : Vector2):
    if !_world.is_walkable(pos):
        return

    var waypoint_id = self.get(pos)
    if waypoint_id == null:  
        var waypoint_data = _waypoints.create_waypoint(pos)
        _waypoint_nodes.append(_waypoint_node_factory.create(waypoint_data))


func get(pos):
    return _waypoints.get_waypoint_id_from_pos(pos)


func update(id, pos):
    var waypoint_id = self.get(pos)
    if !_world.is_walkable(pos) || waypoint_id != null:
        return
    _waypoints.update_waypoints_from_pos(id, pos)


func remove(id):
    _waypoint_nodes[id].queue_free()
    _waypoints.remove_waypoint(id)