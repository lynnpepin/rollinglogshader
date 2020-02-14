extends KinematicBody

var speed = 3
var rolling_log = null

func _physics_process(delta):
	if Input.is_action_pressed("W"):
		move_and_slide(Vector3(0,0,-speed))
	if Input.is_action_pressed("S"):
		move_and_slide(Vector3(0,0,speed))
	if Input.is_action_pressed("A"):
		move_and_slide(Vector3(-speed,0,0))
	if Input.is_action_pressed("D"):
		move_and_slide(Vector3(speed,0,0))
	if Input.is_action_pressed("space"):
		move_and_slide(Vector3(0,speed,0))
	if Input.is_action_pressed("shift"):
		move_and_slide(Vector3(0,-speed,0))	