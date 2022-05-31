extends Node2D

func _ready():
	MusicScene.Rob.play(MusicScene.Robpos)

func _enter_tree():
	if Checkpoint.last_postion:
		$Playerghost.global_position = Checkpoint.last_postion
