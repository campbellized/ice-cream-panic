extends Node2D

var mobs = []

func _ready():
	mobs = get_tree().get_nodes_in_group("Mobs")
	
func _on_mob_death():
	var survivors = 0
	for mob in mobs:
		if mob.is_dead == false:
			survivors += 1
			
	if survivors == 1:
		for mob in mobs:
			if mob.is_dead == true:
				var ghostPacked = preload("res://Ghost.tscn")
				var ghost = ghostPacked.instance()
				var position = mob.get_position()
				ghost.set_position(position)
				ghost.add_to_group("Ghosts")
				get_tree().get_root().add_child(ghost)
		
	if survivors == 0:
		var ghosts = get_tree().get_nodes_in_group("Ghosts")
		
		for ghost in ghosts:
			ghost.player = false
			
		get_tree().change_scene("res://GameOver.tscn")
		print("Game Over")