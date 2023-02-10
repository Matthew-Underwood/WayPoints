class_name MUW_Resolver_Height_Factory

func create(mesh_instance: MeshInstance):
    var height_data = {}
    var world_mesh = mesh_instance.get_mesh()
    var i = 1
    for face in world_mesh.get_faces():
        if i == 5:
            var pos = Vector2(face.x, face.z)
            height_data[pos] = face.y
            i = 0
            continue
        i = i + 1
    return MUW_Resolver_Height.new(height_data)