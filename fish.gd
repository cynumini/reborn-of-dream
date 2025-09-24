class_name Fish
extends Sprite2D

#@export var world: World

func _process(_delta):
	#print(position, " fishy")
	pass
	#var grid_position = Vector2i(position / 32)
	
	#if grid_position in world.map:
		
		#var belt_rotation = world.map[grid_position].rotation
		#var direction = Vector2(sin(belt_rotation), -cos(belt_rotation)).normalized() * 160
		#var target = Vector2(grid_position * 32) + Vector2(16, 16) + direction
		#if int(rad_to_deg(belt_rotation)) % 180 == 90:
			#position.x = move_toward(position.x, target.x, 100 * delta)
			#position.y = target.y
		#else:
			#position.x = target.x
			#position.y = move_toward(position.y, target.y, 100 * delta)
