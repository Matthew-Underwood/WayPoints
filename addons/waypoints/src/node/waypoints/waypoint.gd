extends Node2D

class_name WayPoint

var _position = null # Vector2
var _path = []
var _world : TileMap

func _draw():

	var cell_size = Vector2(16, 16)

	if !_path.empty():
		_world.set_cellv(_position, 2)
		for point in range(1, len(_path)):
			
			var start_position = MU_Ultilities_Vector.vector3_vector2(_path[point - 1])
			var end_position = MU_Ultilities_Vector.vector3_vector2(_path[point])
			
			var start_world_position = _world.map_to_world(start_position) + cell_size
			var end_world_position = _world.map_to_world(end_position) + cell_size

			draw_line(start_world_position, end_world_position, Color.green, 1, true)
			draw_circle(end_world_position, 2, Color.green)
			

func hide() -> void:
	_path = []
	_world.set_cellv(_position, -1)
	update()
	
	
func set_world(world : TileMap) -> void:
	_world = world


func set_path(positions : Array) -> void:
	
	if _position != null:
		_world.set_cellv(_position, -1)
	
	_position = MU_Ultilities_Vector.vector3_vector2(positions.back())
	_path = positions
	update()


func get_position() -> Vector2:
	return _position
	

