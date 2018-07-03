extends Node2D

var mobs = []
var score = 0
var survivors

func _ready():
	$GUI.get_node('Score').set_text(str(Global.score))
	mobs = get_tree().get_nodes_in_group("Mobs")
	survivors = len(mobs)
	$Player.connect("ice_cream_used", self, "_on_ice_cream_used")
	$GUI.connect("timeup", self, "_on_timeup")

func _on_mob_death():
	survivors -= 1
			
	if survivors == 1:
		summon_ghosts()
		
	if survivors == 0:
		gameover()

func _on_ice_cream_used():
	score += 100 * survivors
	$GUI.get_node('Score').set_text(str(score))
	
func summon_ghosts():
	for mob in mobs:
		if mob.is_dead == true:
			var ghostPacked = preload("res://Ghost.tscn")
			var ghost = ghostPacked.instance()
			var position = mob.get_position()
			ghost.set_position(position)
			ghost.add_to_group("Ghosts")
			get_tree().get_root().add_child(ghost)	

func deactivate_ghosts():
	var ghosts = get_tree().get_nodes_in_group("Ghosts")
	
	for ghost in ghosts:
		ghost.player = false
		
func _on_timeup():
	gameover()
		
func gameover():
	deactivate_ghosts()
	Global.score = score
	Global.survivors = survivors
	get_tree().change_scene("res://GameOver.tscn")