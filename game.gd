class_name Game
extends Node2D

signal state_changed
signal won

@export var rice_bowl_scene: PackedScene
@export var fish_scene: PackedScene
@export var level: Node2D
@export var player: Player
var score := 0
var time := 60
var existing_rice_bowl_count := 0
var existing_fish_count := 0


func _ready() -> void:
	randomize()
	state_changed.emit()


func _process(_delta: float) -> void:
	while existing_rice_bowl_count < 9:
		var rice_bowl: RewardItem = rice_bowl_scene.instantiate()
		rice_bowl.position = Vector2(randf_range(8, 640-8), randf_range(8, 360-8))
		existing_rice_bowl_count += 1
		rice_bowl.picked.connect(_on_reward_item_picked)
		level.add_child(rice_bowl)
	while existing_fish_count < 1:
		var fish: RewardItem = fish_scene.instantiate()
		fish.position = Vector2(randf_range(8, 640-8), randf_range(8, 360-8))
		existing_fish_count += 1
		fish.picked.connect(_on_reward_item_picked)
		level.add_child(fish)


func _on_reward_item_picked(reward_item_score: int, reward_name) -> void:
	score += reward_item_score
	match reward_name:
		"Fish":
			existing_fish_count -= 1
		"RiceBowl":
			existing_rice_bowl_count -= 1
	state_changed.emit()
	if time == 0:
		won.emit()


func _on_timer_timeout() -> void:
	if player.can_move == false:
		return
	time = max(time - 1, 0)
	state_changed.emit()


func _on_help_dialog_closed() -> void:
	player.can_move = true
