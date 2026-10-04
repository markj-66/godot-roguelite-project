extends PlayerState

@export var run_state: PlayerState

func physics_update(_delta: float) -> void:
	if player.is_on_floor():
		finished.emit(run_state.name)
	core_movement(_delta, player.run_speed)
	player.velocity += player.get_gravity()
	player.move_and_slide()
