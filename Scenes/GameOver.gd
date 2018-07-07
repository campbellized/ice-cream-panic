extends Node2D

var message

func _ready():
	$GUI.get_node('Score').set_text(str(Global.score))
	$GUI.time_limit = 0
	$GUI.get_node('Countdown').set_text("0")

	if Global.survivors > 0:
		$MarginContainer.get_node("HBoxContainer/VBoxContainer/Title").set_text("Congratulations")
		
		if Global.survivors == 1:
			message = "You saved " + str(Global.survivors) + " human"
	else:
		message = "You saved " + str(Global.survivors) + " humans"		
		
	$MarginContainer.get_node("HBoxContainer/VBoxContainer/Label").set_text(message)
	
func _on_StartButton_pressed():
	Global.score = 0
	get_tree().change_scene("res://Scenes/Level1.tscn")
	
func _on_QuitButton_pressed():
	get_tree().quit()
