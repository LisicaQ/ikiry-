extends Area2D


func _on_levelend_body_entered(body):
	if body.get_name() == "Playerghost":
		Checkpoint.last_postion = Vector2(136, 736)
		get_tree().change_scene("res://level3.tscn")
