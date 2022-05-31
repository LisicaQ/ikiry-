extends KinematicBody2D

const radius = 50
const speed = 1

var d = 0
var motion = Vector2.ZERO
onready var sprite = $Ghost1

func _physics_process(delta):
	
	d += delta
	
	motion.x = sin(d * speed) * radius
	motion.y = cos(d * speed) * radius
	
	if motion.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	motion = move_and_slide(motion)


func _on_Area2D_body_entered(body):
	if body.get_name() == "Player" or body.get_name() == "Playerghost":
		MusicScene.ESNpos = MusicScene.ESN.get_playback_position()
		MusicScene.Robpos = MusicScene.Rob.get_playback_position()
		get_tree().reload_current_scene()

