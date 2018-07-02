extends MarginContainer

func _ready():
	$Score.set_text(str(Global.score))