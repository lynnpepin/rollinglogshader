extends CharacterBody3D

var speed = 6
var rolling_log = null

func _physics_process(delta):
	if Input.is_action_pressed("W"):
		set_velocity(Vector3(0,0,-speed))
		move_and_slide()
	if Input.is_action_pressed("S"):
		set_velocity(Vector3(0,0,speed))
		move_and_slide()
	if Input.is_action_pressed("A"):
		set_velocity(Vector3(-speed,0,0))
		move_and_slide()
	if Input.is_action_pressed("D"):
		set_velocity(Vector3(speed,0,0))
		move_and_slide()
	if Input.is_action_pressed("space"):
		set_velocity(Vector3(0,speed,0))
		move_and_slide()
	if Input.is_action_pressed("shift"):
		set_velocity(Vector3(0,-speed,0))
		move_and_slide()	
	
	$"../Ground".get_active_material(0).set_shader_parameter("player_pos", self.position)
