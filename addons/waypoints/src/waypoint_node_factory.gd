class_name MUW_WayPoint_Node_Factory

var _waypoints_packed_scene : PackedScene
var _waypoint_packed_scene : PackedScene
var _master_node : Node
var _waypoints : Node


func _init(waypoints_packed_scene : PackedScene, waypoint_packed_scene : PackedScene, master_node : Node):
    _waypoints_packed_scene = waypoints_packed_scene
    _waypoint_packed_scene = waypoint_packed_scene
    _master_node = master_node


func create() -> Node:
    if !_master_node.has_node("WayPoints"):
        _waypoints = _waypoints_packed_scene.instance()
        _master_node.add_child(_waypoints)
    
    var waypoint = _waypoint_packed_scene.instance()
    _waypoints.add_child(waypoint)
    return waypoint

