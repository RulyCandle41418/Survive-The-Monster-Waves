extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -500.0

var Health = 100
var Score = 0

var CanDamage = true

@export var monster: CharacterBody2D
@export var player: CharacterBody2D

var GameEnd = false



	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Move_Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Move_Left", "Move_Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
	if Input.is_action_pressed("Mouse_left") && global_position.distance_to(monster.global_position) < 150:
		monster.set_collision_layer_value(1, false)
		monster.set_collision_mask_value(1, false)
		var Reset = true
		CanDamage = false
		Score += 75
		print(Score)
		CanDamage = true
		
		
	
		
func _process(delta: float) -> void:
	if global_position.distance_to(monster.global_position) < 125 && Health > 0 && monster.visible:
		Heal()
		
		
func Heal():
	if global_position.distance_to(monster.global_position) < 125 && Health > 0 && monster.visible and CanDamage:
		Health -= 1
		print(Health)

	if Health < 1:
		print(Score)
		GameEnd = true
		
	if GameEnd:
		player.hide()
		
		
		player.set_collision_layer_value(1, false)
		player.set_collision_mask_value(1, false)
		
 
		
		
		
		
