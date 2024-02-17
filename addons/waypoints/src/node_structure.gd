class_name MUW_Node_Structure

var _master_node : Node
var _packed_waypoints_scene : PackedScene
var _waypoint_factory : MUW_Waypoint_Factory
var _waypoint_nodes : Array

func _init(master_node : Node, packed_waypoints_scene : PackedScene, waypoint_factory : MUW_Waypoint_Factory):
    _master_node = master_node
    _packed_waypoints_scene = packed_waypoints_scene
    _waypoint_factory = waypoint_factory
    

func create(waypoint_data : MUW_Waypoint_Data):
    var waypoints = _master_node.get_node_or_null("WayPoints")
    if waypoints == null:
        waypoints = _packed_waypoints_scene.instance()
        _master_node.add_child(waypoints)
    
    #TODO may remove override
    var waypoint = _waypoint_factory.create()
    waypoint.set_waypoint_data(waypoint_data)
    waypoints.add_child(waypoint)
    _waypoint_nodes = waypoint

func update(id : int, waypoint_data : MUW_Waypoint_Data):

    var waypoint_node = _waypoint_nodes[id]
    waypoint_node.set_waypoint_data(waypoint_data)


func remove(id : int):
    var waypoint_node = _waypoint_nodes[id]
    waypoint_node.queue_free()

    for update_id in range(id, _waypoint_nodes.size()):
        _waypoint_nodes[update_id].set_id(str(update_id + 1))