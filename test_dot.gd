extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var line = $Line
	var line2 = $Line2
	var line_pos = line.transform.origin
	var line_pos2 = line2.transform.origin
	var line_unit = line_pos.normalized()
	var direction = line_pos.direction_to(line_pos2)
	var dot = direction.dot(line_unit)
	print(direction)
	print(dot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
