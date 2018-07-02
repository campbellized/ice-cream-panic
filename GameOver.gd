extends Node2D

func _ready():
	$GUI.get_node('Score').set_text(str(Global.score))

func _on_StartButton_pressed():
	Global.score = 0
	get_tree().change_scene("res://Level1.tscn")
	
func _on_QuitButton_pressed():
	get_tree().quit()
