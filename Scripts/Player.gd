extends KinematicBody2D

var grid_size = 16

onready var ray = $RayCast2D
signal player_move_signal
signal reset_signal

var inputs = {
	'ui_up':Vector2.UP,
	'ui_down':Vector2.DOWN,
	'ui_left':Vector2.LEFT,
	'ui_right':Vector2.RIGHT
}

func _unhandled_input(event):
	for dir in inputs.keys():
		if(event.is_action_pressed(dir)):
			if !$Tween.is_active():
				move(dir)
	if event.is_action_pressed("reset"):
		emit_signal("reset_signal")

func move(dir):
	var vector_pos = inputs[dir] * grid_size
	ray.cast_to = vector_pos
	ray.force_raycast_update()
	$Tween.interpolate_property(self, "position", position, position+vector_pos, .2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	if !ray.is_colliding():
		$Tween.start()
		emit_signal("player_move_signal")
	else:
		var collider = ray.get_collider()
		if collider.is_in_group('box'):
			if collider.move(dir):
				$Tween.start()
				emit_signal("player_move_signal")
			
