class_name Player
extends CharacterBody2D

@export var animated_sprite_2d: AnimatedSprite2D

@export_range(100.0, 500.0) var speed := 100.0

var running := false
var can_move = false


func _process(_delta: float) -> void:
	if not can_move:
		animated_sprite_2d.stop()
		return
	if Input.is_action_pressed("run"):
		running = true
	else:
		running = false
	if velocity.y == 0:
		velocity.x = speed if not running else speed * 1.5
		velocity.x *= Input.get_action_strength("right") - Input.get_action_strength("left")
	if velocity.x == 0:
		velocity.y = speed if not running else speed * 1.5
		velocity.y *= Input.get_action_strength("down") - Input.get_action_strength("up")
	if velocity.length() != 0:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop()
	if velocity.x != 0:
		animated_sprite_2d.flip_h = true if velocity.x < 0 else false
		animated_sprite_2d.animation = "right"
	if velocity.y > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.animation = "down"
	if velocity.y < 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.animation = "up"
	move_and_slide()


func _on_game_won() -> void:
	can_move = false
