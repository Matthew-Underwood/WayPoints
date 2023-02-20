class_name MUP_Dimension_Processor_Factory

var _height_resolver_factory : MUW_Resolver_Height_Factory


func _init(height_resolver_factory : MUW_Resolver_Height_Factory):
    _height_resolver_factory = height_resolver_factory


func create_2d() -> MUP_Dimension_2D_Processor:
    return MUP_Dimension_2D_Processor.new()


func create_3d(mesh_instance: MeshInstance) -> MUP_Dimension_3D_Processor:
    var height_resolver = _height_resolver_factory.create(mesh_instance)
    return MUP_Dimension_3D_Processor.new(height_resolver)