extends MeshInstance

var material = self.get_surface_material(0)

func _physics_process(delta):
	material.set_shader_param("player_pos", $"../Player".translation)
	pass