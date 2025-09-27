class_name Belt
extends Sprite2D

@export var world: World

var id: Vector2i
var next_belt: Belt = null
var items: Array[Sprite2D] = []
var direction: Vector2i
var z: int = -1
const DIRECTION_UP = Vector2i(0, 1)
const DIRECTION_DOWN = Vector2i(0, -1)
const DIRECTION_RIGHT = Vector2i(-1, 0)
const DIRECTION_LEFT = Vector2i(1, 0)


func can_add():
	return len(items) < 4


func z_sort():
	var item_z = z
	for item in items:
		item.z_index = item_z
		item_z += 1


func add_item(item):
	items.append(item)
	if (direction == DIRECTION_LEFT or direction == DIRECTION_RIGHT):
		item.position.y = position.y
	else:
		item.position.x = position.x
	z_sort()


func sort_item(a: Node2D, b: Node2D, belt_direction):
	match belt_direction:
		DIRECTION_UP:
			return a.position.y < b.position.y
		DIRECTION_DOWN:
			return a.position.y > b.position.y
		DIRECTION_LEFT:
			return a.position.x < b.position.x
		DIRECTION_RIGHT:
			return a.position.x > b.position.x


func _physics_process(delta: float) -> void:
	if len(items) == 0: return
	var cell_id = Vector2i(position / 32)
	items.sort_custom(sort_item.bind(direction))
	var next_item_position = Vector2.ZERO
	var new_items: Array[Sprite2D] = []
	while items:
		var item = items.pop_front()
		var next_position = item.position - Vector2(direction * 100 * delta)
		var next_position_cell = Vector2i(next_position / 32)
		if cell_id == next_position_cell: # move on belt
			if next_item_position == Vector2.ZERO or next_position.distance_to(next_item_position) > 8:
				item.move(next_position)
			new_items.append(item)
		elif next_belt and next_belt.can_add(): # move to next belt
			item.move(next_position)
			next_belt.add_item(item)
		else:
			new_items.append(item) # stop at end
		next_item_position = next_position
	items = new_items


func _on_belt_placed_first_pass():
	var next_id = Vector2i(id - direction)
	if next_id in world.map:
		next_belt = world.map[next_id]
	else:
		next_belt = null
	if next_belt == null or next_belt.direction != direction:
		z = 1
	else:
		z = -1


func calc_z():
	if z == -1:
		next_belt.calc_z()
		z = next_belt.z + 4


func _on_belt_placed_second_pass():
	calc_z()
