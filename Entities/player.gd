extends KinematicBody2D

signal ice_cream_used
const SPEED = 200
var velocity
var has_ice_cream = 0

func _ready():
	pass

func _physics_process(delta):
	velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.x != 0 || velocity.y != 0:
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
	
	var colliding_info = move_and_collide(velocity.normalized() * SPEED * delta)
	
	if colliding_info:
		var collided = colliding_info.collider
		if collided.is_in_group("IceCreamStand"):
			get_ice_cream()
		if collided.is_in_group("Mobs") && has_ice_cream == 1:
			use_ice_cream(collided)
			
	ice_cream_logic()

func get_ice_cream():
	self.has_ice_cream = 1
	
func ice_cream_logic():
	if self.has_ice_cream == 1:
		$IceCream.show()
	else: 
		$IceCream.hide()
	
func use_ice_cream(mob):
	if !mob.is_dead:
		self.has_ice_cream = 0
		mob.stamina = mob.MAX_STAMINA
		emit_signal("ice_cream_used")
		mob.modulate_color()
		$AudioIceCream.play()