extends KinematicBody2D

signal mob_death
const MAX_STAMINA = 5.0
var speed = 100
var speed_modifier = 0
var sprite_color
var stamina = 5
var velocity
var movement = Vector2(0, 0)
var is_dead = false

func _ready():
	sprite_color = get_node("Sprite").get_modulate()
	
func _physics_process(delta):
	if stamina > 0:
		velocity = Vector2(movement.x, movement.y)
		
		if velocity.x != 0 || velocity.y != 0:
			if velocity.x > 0:
				$Sprite.flip_h = false
			else:
				$Sprite.flip_h = true
			$Sprite.play("Run")
		else:
			$Sprite.play("Idle")
			
		print(name, " speed is ", speed, " ", speed_modifier)
		var colliding_info = move_and_collide(velocity.normalized() * (speed + speed_modifier) * delta)
		
	else:
		if !is_dead:
			$Sprite.play("Dead")
			$Sweat.hide()
			is_dead = true
			$AudioDeath.play()
			emit_signal("mob_death")
#
#		if colliding_info:
#			var collided = colliding_info.collider
#			if collided.is_in_group("Mobs") || collided.is_in_group("Walls"):
#				$MoveTimer.start()

func _process(delta):
	var mobs = get_tree().get_nodes_in_group("Mobs")
	var body_count = 0
	var multiplier = 50
	for mob in mobs:
		if mob.is_dead == true:
			body_count += 1
	
	if body_count == 3:
		multiplier *= 2
		
	speed_modifier = body_count * multiplier

func calc_movement():
	var x = rand_range(-1, 1)
	var y = rand_range(-1, 1)
	return Vector2(round(x), round(y))
	
func modulate_color():
	var color = sprite_color.darkened(1.0 - stamina / MAX_STAMINA)
	get_node("Sprite").set_modulate(color)
	get_node("Sweat").set_modulate(color)
	
func _on_SunTimer_timeout():
	stamina = stamina - 1
	stamina = max(stamina, 0)
	modulate_color()

func _on_MoveTimer_timeout():
	var new_duration = rand_range(0,1)
	$MoveTimer.wait_time = new_duration
	movement = calc_movement()

func _on_Mob_mob_death():
	var mobs = get_tree().get_nodes_in_group("Mobs")
	var survivors = 0
	for mob in mobs:
		if mob.is_dead == false:
			survivors += 1
	if survivors == 0:
		get_tree().change_scene("res://GameOver.tscn")
