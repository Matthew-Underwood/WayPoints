extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var line = $Line
	var line2 = $Line2

	#var line_facing = line.transform.basis.z
	#var line_pos = line.transform.origin
	#var line_pos2 = line2.transform.origin
	#var facing = line_pos.direction_to(line_pos2)
	#var dot = line_facing.dot(facing)
	#print(dot)
	var line_basis = line.transform.basis.z
	var line_origin = line.transform.origin
	var line_origin2 = line2.transform.origin
	var direction = line_origin - line_origin2
	var angle = line_basis.signed_angle_to (direction, line.transform.basis.y)
	print(rad2deg(angle))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
