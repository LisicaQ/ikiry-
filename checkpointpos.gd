extends Area2D

onready var on = $Oncheckpoint
onready var off = $Offcheckpoint

func _ready():
	on.visible = false
	off.visible = true

func _on_checkpointpos_body_entered(body):
	if body.get_name() == "Player" or body.get_name() == "Playerghost":
		print(Checkpoint.last_postion)
		Checkpoint.last_postion = global_position
		print(Checkpoint.last_postion)
		on.visible = true
		off.visible = false
