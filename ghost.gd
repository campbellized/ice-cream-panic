extends KinematicBody2D

var speed = 50
var speed_modifier = 0
var velocity
var movement = Vector2(0, 0)
var player
var player_position
var is_wandering = false
var wander

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	
func _physics_process(delta):
	velocity = Vector2(movement.x, movement.y)
	var colliding_info = move_and_collide(velocity.normalized() * (speed + speed_modifier) * delta)

func _process(delta):
	var x
	var y
	
	if player:
		player_position = player.position
	else:
		player_position = Vector2()
		
	x = position.x - player_position.x
	y = position.y - player_position.y
	
	if is_wandering:
		y = -sign(y)
		x = -sign(x)

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
		if player:
			player.has_ice_cream = 0
		is_wandering = true
		$Timer.start()

func _on_Timer_timeout():
	is_wandering = false
	$Timer.wait_time = rand_range(3,5)
