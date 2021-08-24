extends Area2D

export var speed = 50.0
var screen_size = Vector2.ZERO
enum polarity {light, dark}
var player_polarity = polarity.light

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if direction.length() > 1:
		direction = direction.normalized()
	if Input.is_action_just_pressed("switch"):
		if player_polarity == polarity.light:
			player_polarity = polarity.dark
		else:
			player_polarity = polarity.light
			
	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if direction.x > 0:
		if player_polarity == polarity.light:
			get_node("AnimatedSprite").animation = "L-right"
		else:
			get_node("AnimatedSprite").animation = "D-right"
	elif direction.x < 0:
		if player_polarity == polarity.light:
			get_node("AnimatedSprite").animation = "L-left"
		else:
			get_node("AnimatedSprite").animation = "D-left"
	else:
		if player_polarity == polarity.light:
			get_node("AnimatedSprite").animation = "L-centre"
		else:
			get_node("AnimatedSprite").animation = "D-centre"
