class_name Cursor
extends Sprite2D

@export var world: World
@export var camera: Camera

var belt_scene = preload("res://belt.tscn")
var fish_scene = preload("res://fish.tscn")

#var grid_position: Vector2i

func place_belt(grid_position: Vector2i):
	var belt: Belt = belt_scene.instantiate()
	belt.setup(world, grid_position, rotation_degrees)
	world.belts[grid_position] = belt
	world.add_child(belt)
	get_tree().call_group("belts", "apply_curve")
	get_tree().call_group("belts", "find_next_belt")
	get_tree().call_group("belts", "sort_z")
	print("place belt")
		#world.map[grid_position].direction = Vector2i(round(-sin(rotation_rad)), round(cos(rotation_rad)))
		#world.map[grid_position].world = world
		#world.map[grid_position].id = grid_position
		#world.belt_placed_first_pass.connect(world.map[grid_position]._on_belt_placed_first_pass)
		#world.belt_placed_second_pass.connect(world.map[grid_position]._on_belt_placed_second_pass)
		#world.add_child(world.map[grid_position])
		#world.belt_placed_first_pass.emit()
		#world.belt_placed_second_pass.emit()
		#for item in world.get_item_in_cells(grid_position):
			#world.map[grid_position].add_item(item)
#
#
func remove_belt(grid_position: Vector2i):
	if grid_position not in world.belts:
		return
	world.belts[grid_position].queue_free()
	world.belts.erase(grid_position)


func _process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	var grid_position = Vector2i((mouse_position / world.grid_size).round())
	position = grid_position * world.grid_size

	if Input.is_action_pressed("put"):
		var belt_in_cell = world.belts.get(grid_position)
		if belt_in_cell and not is_equal_approx(belt_in_cell.rotation, rotation):
			remove_belt(grid_position)
			place_belt(grid_position)
		elif not belt_in_cell:
			place_belt(grid_position)
	if Input.is_action_just_released("drop"):
		var belt_in_cell = world.belts.get(grid_position)
		if belt_in_cell and not belt_in_cell.is_full():
			var item: Fish = fish_scene.instantiate()
			world.add_child(item)
			belt_in_cell.add_item(item)
	if Input.is_action_pressed("remove"):
		remove_belt(grid_position)
	if Input.is_action_just_pressed("rotate"):
		rotation_degrees += 90
