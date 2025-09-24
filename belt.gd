class_name Belt
extends Sprite2D

@export var world: World
var id: Vector2i
var next_belt: Belt = null
var items: Array[Sprite2D] = []
var direction: Vector2

func can_add():
	return len(items) < 2

func add_item(item: Sprite2D):
	#item.position = position
	#item.position.y += 16
	items.append(item)
	#print("new item: ", item, " current items: ", items)

func _process(delta: float) -> void:
	var end_of_belt = position - direction * 16
	var target = end_of_belt
	var z = 1
	for item in items:
		item.z_index = z
		z += 1
		if end_of_belt.x == position.x:
			item.position.x = target.x
		else:
			item.position.y = target.y
		item.position = item.position.move_toward(target, 100 * delta)
		target += direction * 16
	var next_id = Vector2i(Vector2(id) - direction)
	if next_id in world.map:
		next_belt = world.map[next_id]
	else:
		next_belt = null
	for item in items:
		if next_belt and item.position == end_of_belt and next_belt.can_add():
			next_belt.add_item(item)
			items.erase(item)
