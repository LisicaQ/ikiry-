extends Node2D

var fallingspike1 = preload("res://Spikestatic.tscn")
var pos = 0
var finalpos = 0

func _ready():
	$Timer.start()


func _on_Timer_timeout():
	randomize()
	var fallingspikes = [fallingspike1]
	var kinds = fallingspikes[randi() % fallingspikes.size()]
	var fallingspike = kinds.instance()
	pos = randi() % 18 - 9
	finalpos = pos * 16
	fallingspike.position = Vector2(finalpos, 0)
	add_child(fallingspike)
