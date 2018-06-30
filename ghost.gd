extends KinematicBody2D

var speed = 50
var speed_modifier = 0
var velocity
var movement = Vector2(0, 0)
var player
var player_position

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	
func _physics_process(delta):
	velocity = Vector2(movement.x, movement.y)
	
#	if velocity.x != 0 || velocity.y != 0:
#		if velocity.x > 0:
#			$Sprite.flip_h = false
#		else:
#			$Sprite.flip_h = true
#
#	print(name, " speed is ", speed, " ", speed_modifier)
	var colliding_info = move_and_collide(velocity.normalized() * (speed + speed_modifier) * delta)

func _process(delta):
	player_position = player.position
	var x = position.x - player_position.x
	var y = position.y - player_position.y
	
	if x > 0:
		x = -1
	else: 
		x = 1
		
	if y > 0:
		y = -1
	else: 
		y = 1
		
	movement = Vector2(x, y)

func _on_Collision_body_entered(body):
	if body.is_in_group("Player"):
		player.has_ice_cream = 0
