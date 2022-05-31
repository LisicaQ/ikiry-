extends KinematicBody2D

# constant variables
const speed = 1024
const wobble = 200
const glide = 0.05

var motion = Vector2.ZERO
var i = 0
var move = 0
var bob = 0

onready var sprite = $Ghost2


func _physics_process(delta):
	
	if motion.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	if move == 1:
		motion.x = speed * delta
	elif move == 2:
		motion.x = speed * delta
	elif move == 3:
		motion.x = lerp(motion.x, 0, glide)
	elif move == 4:
		motion.x = -speed * delta
	elif move == 5:
		motion.x = -speed * delta
	elif move == 0:
		motion.x = lerp(motion.x, 0, glide)
	
	if bob == 1:
		motion.y = wobble * delta
	elif bob == 0:
		motion.y = -wobble * delta
	
	
	motion = move_and_slide(motion,Vector2.UP)

func _on_bobbingtimer_timeout():
	bob += 1
	if bob == 2:
		bob = 0
#	print("bob", bob)
	pass # Replace with function body.


func _on_leftrighttimer_timeout():
	move += 1
	if move == 6:
		move = 0
#	print("move", move)
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.get_name() == "Player" or body.get_name() == "Playerghost":
		MusicScene.ESNpos = MusicScene.ESN.get_playback_position()
		MusicScene.Robpos = MusicScene.Rob.get_playback_position()
		get_tree().reload_current_scene()
