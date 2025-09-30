class_name Camera
extends Camera2D

@export_range(0, 0.5, 0.01) var zoom_speed: float = 0.05
@export_range(0, 5, 0.1) var max_zoom: float = 2
@export_range(0, 5, 0.1) var min_zoom: float = 0.5
@export_range(100, 1000) var speed: float = 300

var zoom_level: float = 1.0

func _process(delta: float) -> void:
	# movement
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	self.position += direction * speed * delta
	
	# zoom level
	var zoom_direction: int = 0
	if Input.is_action_just_released("zoom_in"):
		zoom_direction = 1
	elif Input.is_action_just_released("zoom_out"):
		zoom_direction = -1
	zoom_level = clamp(zoom_level + zoom_speed * zoom_direction, min_zoom, max_zoom)
	zoom = Vector2.ONE * zoom_level
