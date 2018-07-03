extends MarginContainer

signal timeup
var time_limit = 60

func _ready():
	$Score.set_text(str(Global.score))
	$Countdown.set_text(str(time_limit))

func _on_Timer_timeout():
	time_limit -= 1
	if time_limit < 0:
		emit_signal("timeup")
	else:
		var time = max(time_limit, 0)
		$Countdown.set_text(str(time))
	
