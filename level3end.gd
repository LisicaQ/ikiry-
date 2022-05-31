extends Area2D


func _on_levelend_body_entered(body):
	if body.get_name() == "Playerghost":
		get_tree().change_scene("res://level4.tscn")
