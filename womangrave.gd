extends StaticBody2D



func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		$Control/DialogBox.visible = true
		Checkpoint.finished1 = true
		Checkpoint.last_postion = Vector2(72, 120)
