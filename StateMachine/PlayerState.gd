extends State
class_name PlayerState

@export var player : Player
@export var dash_state: PlayerState

func core_movement(delta: float, speed: float) -> void:
	var direction := player.get_movement_direction()
	player.velocity = direction * speed
	player.look_toward_direction(direction, delta)

func check_dash(event: InputEvent) -> void:
	if event.is_action_pressed("dash") and player.can_dash():
		var direction = player.get_movement_direction()
		finished.emit(dash_state.name, {"direction":direction})
