class_name Belt
extends Sprite2D

@export var world: World

var belt_texture: Texture2D = preload("res://assets/belt.png")
var curved_belt_texture: Texture2D = preload("res://assets/curved_belt.png")

@export_range(1, 8, 1) var max_items = 1

const UP = Vector2i(0, -1)
const DOWN = Vector2i(0, 1)
const LEFT = Vector2i(-1, 0)
const RIGHT = Vector2i(1, 0)

var id: Vector2i
var items: Array[Fish] = [] 
var direction: Vector2i

func setup(world_node: World, grid_position: Vector2i, belt_rotation: float):
	texture = belt_texture
	self.world = world_node
	self.position = grid_position * world.grid_size
	self.rotation_degrees = belt_rotation
	self.id = grid_position
	self.direction = Vector2(sin(rotation), -cos(rotation))

func is_full():
	return len(items) == max_items

func add_item(item: Fish):
	item.position = position
	items.append(item)


func apply_curve():
	var up_belt: Belt = world.belts.get(id + UP)
	var down_belt: Belt = world.belts.get(id + DOWN)
	var left_belt: Belt = world.belts.get(id + LEFT)
	var right_belt: Belt = world.belts.get(id + RIGHT)
	var from_top = false
	var from_bottom = false
	var from_left = false
	var from_right = false
	if up_belt and up_belt.direction == DOWN and direction != UP:
		from_top = true
	if down_belt and down_belt.direction == UP and direction != DOWN:
		from_top = true
	if left_belt and left_belt.direction == RIGHT and direction != LEFT:
		from_left = true
	if right_belt and right_belt.direction == LEFT and direction != RIGHT:
		from_right = true
	var count = int(from_top) + int(from_bottom) + int(from_left) + int(from_right)
	if count == 0:
		pass # not curved
	elif count > 1:
		pass # not curved
	else:
		pass # can be curved

#@export var world: World
#
#var id: Vector2i
#var next_belt: Belt = null
#var items: Array[Sprite2D] = []
#var direction: Vector2i
#var z: int = -1
#const DIRECTION_UP = Vector2i(0, 1)
#const DIRECTION_DOWN = Vector2i(0, -1)
#const DIRECTION_RIGHT = Vector2i(-1, 0)
#const DIRECTION_LEFT = Vector2i(1, 0)
#
#
#func can_add():
	#return len(items) < 4
#
#
#func z_sort():
	#var item_z = z
	#for item in items:
		#item.z_index = item_z
		#item_z += 1
#
#
#func add_item(item):
	#items.append(item)
	#if (direction == DIRECTION_LEFT or direction == DIRECTION_RIGHT):
		#item.position.y = position.y
	#else:
		#item.position.x = position.x
	#z_sort()
#
#
#func sort_item(a: Node2D, b: Node2D, belt_direction):
	#match belt_direction:
		#DIRECTION_UP:
			#return a.position.y < b.position.y
		#DIRECTION_DOWN:
			#return a.position.y > b.position.y
		#DIRECTION_LEFT:
			#return a.position.x < b.position.x
		#DIRECTION_RIGHT:
			#return a.position.x > b.position.x
#
#
#func _physics_process(delta: float) -> void:
	#if len(items) == 0: return
	#var cell_id = Vector2i(position / 32)
	#items.sort_custom(sort_item.bind(direction))
	#var next_item_position = Vector2.ZERO
	#var new_items: Array[Sprite2D] = []
	#while items:
		#var item = items.pop_front()
		#var next_position = item.position - Vector2(direction * 100 * delta)
		#var next_position_cell = Vector2i(next_position / 32)
		#if cell_id == next_position_cell: # move on belt
			#if next_item_position == Vector2.ZERO or next_position.distance_to(next_item_position) > 8:
				#item.move(next_position)
			#new_items.append(item)
		#elif next_belt and next_belt.can_add(): # move to next belt
			#item.move(next_position)
			#next_belt.add_item(item)
		#else:
			#new_items.append(item) # stop at end
		#next_item_position = next_position
	#items = new_items
#
#
#func _on_belt_placed_first_pass():
	#var next_id = Vector2i(id - direction)
	#if next_id in world.map:
		#next_belt = world.map[next_id]
	#else:
		#next_belt = null
	#if next_belt == null or next_belt.direction != direction:
		#z = 1
	#else:
		#z = -1
#
#
#func calc_z():
	#if z == -1:
		#next_belt.calc_z()
		#z = next_belt.z + 4
#
#
#func _on_belt_placed_second_pass():
	#calc_z()
