class_name Fish
extends Sprite2D
#
#@export var world: World
#
#
#var can_move = true
#
#func move(new_position: Vector2):
	#if (can_move):
		#self.position = new_position
		#can_move = false
#
#func _physics_process(_delta: float) -> void:
	#can_move = true
