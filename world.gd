class_name World
extends Node2D

var fish_scene: PackedScene = preload("res://fish.tscn")

var map: Dictionary[Vector2i, Belt] = {}

func _process(_delta: float) -> void:
	if Input.is_action_just_released("drop"):
		var mouse: Vector2 = get_global_mouse_position()
		var grid_position = Vector2i(mouse / 32)
		if grid_position in map and map[grid_position].can_add():
			var fish: Fish = fish_scene.instantiate()
			fish.position = mouse
			map[grid_position].add_item(fish)
			add_child(fish)
		elif grid_position in map:
			pass
		else:
			var fish: Fish = fish_scene.instantiate()
			fish.position = mouse
			add_child(fish)
