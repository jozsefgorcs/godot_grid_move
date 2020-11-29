extends Node2D

var game_end = false
var steps = 0

func _process(_delta):
	$StepsLabel.text = "Steps: "+str(steps)
	if game_end:
		return
	var spot_count = $Spots.get_child_count()
	for spot in $Spots.get_children():
		if spot.occupied:
			spot_count -= 1
	if spot_count == 0:
		$AcceptDialog.popup()
		game_end = true


func _on_AcceptDialog_confirmed():
	get_tree().reload_current_scene()


func _on_Player_player_move_signal():
	steps += 1 


func _on_Player_reset_signal():
	get_tree().reload_current_scene()
