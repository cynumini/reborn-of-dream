class_name World
extends Node2D

signal belt_placed_first_pass
signal belt_placed_second_pass

var fish_scene: PackedScene = preload("res://fish.tscn")

var tick = 0

var map: Dictionary[Vector2i, Belt] = {}


func _ready():
	randomize()


func min_distance_to_positions(target_position: Vector2, positions: Array[Vector2]):
	var min_distance: float = INF
	for current_position in positions:
		min_distance = min(min_distance, current_position.distance_to(target_position))
	return min_distance


func get_item_in_cells(index: Vector2i) -> Array[Node2D]:
	var items_in_cell: Array[Node2D] = [] 
	for item in get_tree().get_nodes_in_group("items"):
		var grid_position_of_item = Vector2i(item.position / 32)
		if grid_position_of_item == index:
			items_in_cell.append(item)
	return items_in_cell


func _process(_delta: float) -> void:
	if Input.is_action_just_released("drop"):
		var mouse: Vector2 = get_global_mouse_position()
		var grid_position = Vector2i(mouse / 32)
		if grid_position in map and map[grid_position].can_add():
			var fish: Fish = fish_scene.instantiate()
			fish.world = self
			fish.position = mouse
			map[grid_position].add_item(fish)
			add_child(fish)
		elif grid_position not in map:
			var items_in_cell_positions: Array[Vector2] = []
			for item in get_item_in_cells(grid_position):
				items_in_cell_positions.append(item.position)
			if len(items_in_cell_positions) < 4:
				var fish: Fish = fish_scene.instantiate()
				fish.world = self
				var new_position = mouse
				if min_distance_to_positions(new_position, items_in_cell_positions) < 16:
					var x = grid_position.x * 32
					var y = grid_position.y * 32
					while true:
						new_position = Vector2(randf_range(x, x + 32), randf_range(y, y + 32))
						if min_distance_to_positions(new_position, items_in_cell_positions) >= 16:
							break
				fish.position = new_position
				add_child(fish)
