extends MeshInstance


func _ready():
	for x in range(-1, 2):
		for z in range(-1, 2):
			var direction = Vector3(x, 0, z)
			direction = Vector3(direction.x, 0, direction.z)
			var angle = Vector3(0, 0, 1).signed_angle_to(direction, Vector3(0, 1, 0))
			var id = str(angle).sha1_text().left(4)
			
			print("Direction : " + str(direction))
			print("Radians : " + str(angle))
			print("SHA1 : " + str(id))