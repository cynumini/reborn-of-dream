extends MarginContainer

@export var game: Game
@export var rice_bowl_count: Label
@export var fish_count: Label
@export var time_label: Label
@export var won_dialog: AcceptDialog


func _on_game_state_changed() -> void:
	rice_bowl_count.text = "Rice bowls: " + str(game.score % 5)
	fish_count.text = "Fish: %d" % floor(game.score / 5.0)
	time_label.text = "Seconds lest: " +  str(game.time)
	


func _on_game_won() -> void:
	won_dialog.dialog_text = "You collected %d fish and %d rice bowls!" % [floor(game.score / 5.0), game.score % 5]
	won_dialog.show()


func _on_accept_dialog_closed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
