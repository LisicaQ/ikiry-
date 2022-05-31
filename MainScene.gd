extends Node2D

func _enter_tree():
	if Checkpoint.last_postion:
		$Player.global_position = Checkpoint.last_postion
