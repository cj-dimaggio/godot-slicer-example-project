tool

extends RigidBody

class_name Sliceable

export(Material) var cross_section_material
export(Mesh) var mesh_override
export var start_static = false

func _ready():
	if mesh_override:
		$MeshInstance.mesh = mesh_override
	# Setup the collision shape to be the mesh's shape
	var shape = ConvexPolygonShape.new()
	shape.points = $MeshInstance.mesh.surface_get_arrays(0)[Mesh.ARRAY_VERTEX]
	shape.margin = 0.015
	var owner_id = self.create_shape_owner(self)
	self.shape_owner_add_shape(owner_id, shape)
	if start_static:
		self.mode = RigidBody.MODE_STATIC

func setup(mesh: Mesh, position: Transform):
	$MeshInstance.mesh = mesh
	self.transform = position
	self.mode = RigidBody.MODE_RIGID

func cut_plane(plane: Plane):
	var sliced: SlicedMesh = $Slicer.slice_by_plane($MeshInstance.mesh, plane, cross_section_material)
	sliced.lower

func cut(origin: Vector3, normal: Vector3):
	return $Slicer.slice($MeshInstance.mesh, self.transform, origin, normal, cross_section_material)
