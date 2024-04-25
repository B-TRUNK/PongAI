extends StaticBody2D

var ball_position : Vector2
var padd_ball_distance : int
var move_by #determines how far the paddle will move
var window_height : int
var paddle_height : int



# Called when the node enters the scene tree for the first time.
func _ready():
	window_height = get_viewport_rect().size.y
	paddle_height = $ColorRect.size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move the paddle towards the ball
	#so we need to know exactly where the ball is
	ball_position = get_parent().get_node("Ball").position
	padd_ball_distance = position.y - ball_position.y
	
	#below if stat. is for smooth paddle movement
	if abs(padd_ball_distance) > get_parent().PADDLE_SPEED * delta :
		move_by = get_parent().PADDLE_SPEED * delta * (padd_ball_distance / abs(padd_ball_distance)) #(padd_ball_distance / abs(padd_ball_distance) is a math trick to find the sign of the direction , to know where to move the paddle
	else:
		move_by = padd_ball_distance
		
	position.y -= move_by
	
	#also limit the paddle movement to not exceed the upper and lower collisions
	position.y = clamp(position.y ,paddle_height / 2 ,window_height - paddle_height / 2)
