extends MeshInstance


# Called when the node enters the scene tree for the first time.
func _ready():
	var line_node = $Line
	var line = MUW_Line_Factory.new()
	line.create(line_node, [Vector3(0.5 ,0, 0.5), Vector3(1.5 ,0, 0.5), Vector3(2.5 ,0.2 , 0.5)])
