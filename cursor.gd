class_name Cursor
extends Sprite2D

var belt_scene = preload("res://belt.tscn")

@export var world: World

var grid_position = Vector2i(0, 0)
var item_rotation = 0


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		grid_position.x = int(event.position.x / 32)
		grid_position.y = int(event.position.y / 32)
		position = Vector2(grid_position * 32) + Vector2(16, 16)


func put():
	if grid_position not in world.map:
		var rotation_rad = deg_to_rad(item_rotation)
		world.map[grid_position] = belt_scene.instantiate()
		world.map[grid_position].position = Vector2(grid_position * 32) + Vector2(16, 16)
		world.map[grid_position].rotation = rotation_rad
		world.map[grid_position].direction = Vector2(-sin(rotation_rad), cos(rotation_rad))
		world.map[grid_position].world = world
		world.map[grid_position].id = grid_position
		world.add_child(world.map[grid_position])


func remove():
	if grid_position in world.map:
		world.map[grid_position].queue_free()
		world.map.erase(grid_position)


func _process(_delta):
	if Input.is_action_pressed("put"):
		if grid_position in world.map and world.map[grid_position].rotation != rotation:
			remove()
			put()
		else:
			put()
	if Input.is_action_pressed("remove"):
		remove()
	if Input.is_action_just_pressed("rotate"):
		item_rotation = (item_rotation + 90) % 360
		rotation = deg_to_rad(item_rotation)
