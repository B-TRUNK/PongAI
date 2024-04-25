extends StaticBody2D

var window_height : int
var paddle_height : int



func _ready():
	window_height = get_viewport_rect().size.y
	paddle_height = $ColorRect.get_size().y
	



func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= (get_parent().PADDLE_SPEED) * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += (get_parent().PADDLE_SPEED) * delta

	#to force paddle to not exceed the upper & bottom borders:
	position.y = clamp(position.y ,paddle_height / 2 ,window_height - paddle_height /2 )



func _on_down_button_button_down():
	position.y += 90
	pass
	
func _on_up_button_button_up():
	position.y -= 90
	pass
