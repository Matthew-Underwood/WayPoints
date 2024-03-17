extends MeshInstance

func _ready():
	var angle1 = Vector2(0.5, 0.5)
	var angle2 = Vector2(0.5, 1.5)

	var direction = angle1.angle_to(angle2)
	print(rad2deg(direction))
	print(direction)