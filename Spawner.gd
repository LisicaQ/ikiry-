extends Node2D

var fallingspike1 = preload("res://fallingspike1.tscn")
var fallingspike2 = preload("res://fallingspike2.tscn")
var pos = 0
var finalpos = 0

func _on_Timer_timeout():
	randomize()
	var fallingspikes = [fallingspike1, fallingspike2]
	var kinds = fallingspikes[randi() % fallingspikes.size()]
	var fallingspike = kinds.instance()
	pos = randi() % 18 - 9
	finalpos = pos * 16
	fallingspike.position = Vector2(finalpos, 0)
	add_child(fallingspike)
