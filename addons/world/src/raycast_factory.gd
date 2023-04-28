class_name MUW_RayCast_Factory


func create(cast_to : Vector3) -> RayCast:
    var rc = RayCast.new()
    rc.enabled = true
    rc.cast_to = cast_to
    return rc