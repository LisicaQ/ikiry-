extends KinematicBody2D

# constant variables
const accel = 512
const maxspeed = 64
const friction = 0.25
const airresist = 0.02
const gravity = 200
const jumpforce = 128
const walljumpforce = 96
const accelwalljump = 256
const jumplimit = 2

# setting variables
var jumpcount = 2
var score : int = 0
var finished = true

var motion = Vector2.ZERO

onready var sprite = $playeridle

func _physics_process(delta):
	
	if finished == true:
		# left and right input
		var x_input = Input.get_action_strength("mright") - Input.get_action_strength("mleft")

		# putting input into movement
		if x_input != 0:
			motion.x += x_input * accel * delta
			motion.x = clamp(motion.x, -maxspeed, maxspeed)
			sprite.flip_h = x_input < 0
			

		# gravity
		motion.y += gravity * delta

		# jumping
		if Input.is_action_just_pressed("mjump") and jumpcount > 0:
			motion.y = -jumpforce
			jumpcount =- 1

		# right wall jump
		if Input.is_action_just_pressed("mjump") and not is_on_floor() and ntrwall():
			motion.x = -accelwalljump
			motion.y = -walljumpforce

		# left wall jump
		if Input.is_action_just_pressed("mjump") and not is_on_floor() and ntlwall():
			motion.x = +accelwalljump
			motion.y = -walljumpforce

		# on floor mechanics
		if is_on_floor():
			jumpcount = jumplimit
			# friction only works on floor
			if x_input == 0:
				motion.x = lerp(motion.x, 0, friction)
		else:
			if Input.is_action_pressed("mleft") and ntlwall() and not Input.is_action_just_pressed("mjump"):
				motion.y = 0
			if Input.is_action_pressed("mright") and ntrwall() and not Input.is_action_just_pressed("mjump"):
				motion.y = 0
			# jumping height
			if Input.is_action_just_released("mjump") and motion.y < -jumpforce/2:
				motion.y = -jumpforce/2
			
			# air resistance only works in air
			if x_input == 0:
				motion.x = lerp(motion.x, 0, airresist)
		motion = move_and_slide(motion, Vector2.UP)

	if Checkpoint.finished1 == true and Input.is_action_pressed("payrespect"):
		finished = false
		sprite.visible = false
		$Seppuku.visible = true
		$AnimationPlayer.play("Seppuku")
		
	
	# death function
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Spike2" or collision.collider.name == "side2sideghost2" or collision.collider.name == "circleghost" or collision.collider.name == "fallingspike1" or collision.collider.name == "fallingspike2":
			MusicScene.ESNpos = MusicScene.ESN.get_playback_position()
			MusicScene.Robpos = MusicScene.Rob.get_playback_position()
			get_tree().reload_current_scene()

func ntwall():
	return ntrwall() or ntlwall()

func ntrwall():
	return $cright.is_colliding()

func ntlwall():
	return $cleft.is_colliding()


func _on_AnimationPlayer_animation_finished(anim_name):
	print("it is done")
	MusicScene.ESN.stop()
	get_tree().change_scene("res://level2.tscn")
