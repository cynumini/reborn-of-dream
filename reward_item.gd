class_name RewardItem
extends Area2D

signal picked(score: int, reward_name: String)

@export var score: int = 1
@export var reward_name: String = "Reward"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		picked.emit(score, reward_name)
		queue_free()
