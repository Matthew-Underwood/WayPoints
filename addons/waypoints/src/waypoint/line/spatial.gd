class_name MUW_Waypoint_Line_Spatial


func create(from : Vector3, to : Vector3):
    
    from = from.floor()
    to = to.floor()
    to =+ Vector3(0.5, 0.5 ,0)

    #TODO account for if to and from are the same or out of range
    for x in [-1, 0, 1]:
        for y in [-1, 0, 1]:
            var relative = to + Vector3(x, y, 0)
            if from == relative && relative != Vector2.ZERO:
                return to + (relative * 0.5)
