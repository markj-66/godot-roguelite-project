extends PlayerState

@export var fall_state: PlayerState

func physics_update(_delta: float) -> void:
	core_movement(_delta, player.run_speed)
	if player.get_movement_direction():
		player.mannequin_animation_tree.blend_target = 1.0
	else:
		player.mannequin_animation_tree.blend_target = -1.0
	if not player.is_on_floor():
		finished.emit(fall_state.name)
	player.move_and_slide()

func handle_input(_event: InputEvent) -> void:
	check_dash(_event)
	check_attack(_event)
