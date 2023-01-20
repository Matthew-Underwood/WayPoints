class_name MUW_Resolver_Height_Factory

func create(mesh_instance: MeshInstance):
    var height_data = {}
    var mdt = MeshDataTool.new()
    var world_mesh = mesh_instance.get_mesh()
    var mesh_pos = mesh_instance.transform.origin
    var i = 0
    for face in world_mesh.get_faces():
        var face_pos = mesh_pos - face
        if i % 6 == 0:
            var pos = Vector2(face_pos.x, face_pos.z)
            height_data[pos] = face_pos.y
        i = i + 1
    return MUW_Resolver_Height.new(height_data)