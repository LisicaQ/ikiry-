extends StaticBody2D

func _ready():
	$AnimationPlayer.play("Orbs")

func _on_Area2D_body_entered(body):
	if body.get_name() == "Playerghost":
		body.screwgravity()
