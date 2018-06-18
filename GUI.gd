extends MarginContainer

var score = 0

func _ready():
	print('YO')
	get_parent().get_node("Player").connect("ice_cream_used", self, "_on_ice_cream_used")
	
func _on_ice_cream_used():
	score += 100
	print(score)
	$Score.set_text(str(score))