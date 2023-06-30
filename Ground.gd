extends MeshInstance3D

var material = self.get_surface_override_material(0)
@onready var  player = $"../Player"

func _physics_process(delta):
	#await player.NOTIFICATION_ENTER_WORLD
	#print("Ready!")
	#material.set_shader_parameter("player_pos", player.position)
