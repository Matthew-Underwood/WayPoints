extends MeshInstance

func _ready():
	var z_axis = Vector3(0, 0, 1)
	var pos_from = Vector3(1, 0, 1)
	var pos_to = Vector3(0, 0, 1)
	var direction = pos_from - pos_to
	var direction_xz = Vector3(direction.x, 0, direction.z)
	var angle_radians_y = z_axis.angle_to(direction_xz)
	print(angle_radians_y)

	#0
