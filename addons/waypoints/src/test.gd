class_name MUW_Path_Structure

var _waypoint_factory : MUW_Waypoint_Factory
var _waypoint_nodes : Array

func _init(waypoint_factory : MUW_Waypoint_Factory):
	_waypoint_factory = waypoint_factory
	

func create(waypoint_data : MUW_Waypoint_Data):

	var waypoint = _waypoint_factory.create(waypoint_data)
	_waypoint_nodes.append(waypoint)


#TODO look into if id will reference the waypoint nodes correctly
func update(id : int, waypoint_data : MUW_Waypoint_Data):

	var waypoint_node = _waypoint_nodes[id]
	waypoint_node.set_waypoint_data(waypoint_data)


func remove(id : int):
	var waypoint_node = _waypoint_nodes[id]
	waypoint_node.queue_free()
	_waypoint_nodes.remove(id)

	for update_id in range(id, _waypoint_nodes.size()):
		_waypoint_nodes[update_id].set_id(str(update_id + 1))
