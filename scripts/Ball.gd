extends CharacterBody2D

var window_size : Vector2
const START_SPEED : int = 500
const  ACCELERATION : int = 50
var speed : int
var direction : Vector2
const MAX_Y_VECTOR : float = 0.6

func _ready():
	window_size = get_viewport_rect().size
	
	
#to give the ball a new direction everytime game start	
func _new_ball():
	position.x = window_size.x / 2
	position.y = randi_range(200 ,window_size.y -200)
	
	#start speed of the ball before acceleration
	speed = START_SPEED
	direction = random_direction()
	
func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		#if ball hits the paddle
		if collider == $"../Player" or collider == $"../AI":
			speed += ACCELERATION
			#direction = direction.bounce(collision.get_normal())
			direction = new_cdirection(collider)
		#if the ball hits one of the walls
		else:
			direction = direction.bounce(collision.get_normal())
		
func random_direction():
	var new_direction := Vector2()
	new_direction.x = [1 ,-1].pick_random()
	new_direction.y = randf_range(-1 ,1)
	return new_direction.normalized()
	
#below function is to make the movement of the ball unpredictble
func new_cdirection(collider):
	var ball_y = position.y
	var padd_y = collider.position.y
	var distance = ball_y - padd_y
	var new_dir := Vector2()
	
	#flip the horizontal direction
	if direction.x > 0 :
		new_dir.x = -1
	else :
		new_dir.x = 1
		
	new_dir.y = (distance / (collider.paddle_height / 2)) * MAX_Y_VECTOR
	
	return new_dir.normalized()
		
		
	
