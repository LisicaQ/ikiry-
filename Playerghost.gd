extends KinematicBody2D

# constant variables
const accel = 512
const maxspeed = 64

# setting variables
var gravity = -50

var motion = Vector2.ZERO

onready var sprite = $Playerghost

func _physics_process(delta):
	
	# left and right input
	var x_input = Input.get_action_strength("mright") - Input.get_action_strength("mleft")

	# putting input into movement
	if x_input != 0:
		motion.x += x_input * accel * delta
		motion.x = clamp(motion.x, -maxspeed, maxspeed)
		sprite.flip_h = x_input < 0
		
	# gravity
	motion.y += gravity * delta
	motion = move_and_slide(motion, Vector2.UP)
	if gravity > 0:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	
	# death function
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Spike" or collision.collider.name == "side2sideghost" or collision.collider.name == "circleghost" or collision.collider.name == "fallingspike1" or collision.collider.name == "fallingspike2" or collision.collider.name == "side2sideghost3":
			MusicScene.ESNpos = MusicScene.ESN.get_playback_position()
			MusicScene.Robpos = MusicScene.Rob.get_playback_position()
			get_tree().reload_current_scene()

func screwgravity():
	gravity = -gravity
