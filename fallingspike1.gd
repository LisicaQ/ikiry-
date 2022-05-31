extends KinematicBody2D

var flip : int = randi() % 2
var gravity = 200
var motion = Vector2.ZERO

func _physics_process(delta):
	
	motion.y += gravity * delta
	
	motion = move_and_slide(motion, Vector2.UP)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Player" or collision.collider.name == "Playerghost":
			MusicScene.ESNpos = MusicScene.ESN.get_playback_position()
			MusicScene.Robpos = MusicScene.Rob.get_playback_position()
			get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player" or body.get_name() == "Playerghost":
		MusicScene.ESNpos = MusicScene.ESN.get_playback_position()
		MusicScene.Robpos = MusicScene.Rob.get_playback_position()
		get_tree().reload_current_scene()
