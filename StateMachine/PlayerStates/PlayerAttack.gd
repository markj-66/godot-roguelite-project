extends PlayerState

@export var movement_speed := 0.0
@export var dash_cancel := false
@export var attack_component: AttackComponent
@export var run_state: PlayerState
@export var next_attack: PlayerState
@export var queued_attack_time := 0.5
@export var attack_animation_name := "SlashAttack"
@export var damage: float = 8.0

var queued_attack := false
var aim_direction := Vector3.ZERO

func enter(_previous_state_path: String, _data := {}) -> void:
	queued_attack = false
	attack_component.reset_exceptions()
	player.mannequin_animation_tree.change_immediate(attack_animation_name)
	player.mannequin_animation_tree.animation_finished.connect(finish_attack, CONNECT_ONE_SHOT)
	var timer = get_tree().create_timer(queued_attack_time)
	timer.timeout.connect(attempt_queue_attack)
	aim_direction = player.get_aim_direction()
	
func handle_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("click"):
		queued_attack = true
	if dash_cancel == true:
		check_dash(_event)
		
func exit() -> void:
	if player.mannequin_animation_tree.animation_finished.is_connected(finish_attack):
		player.mannequin_animation_tree.animation_finished.disconnect(finish_attack)
	
func physics_update(_delta: float) -> void:
	#core_movement(_delta, movement_speed)
	player.velocity = player.get_movement_direction() * movement_speed
	attack_component.deal_damage(damage, Vector3.ZERO)
	player.look_toward_direction(aim_direction, 1.0)
	player.move_and_slide()

func finish_attack(_animation_name: String) -> void:
	finished.emit(run_state.name)

func attempt_queue_attack() -> void:
	if next_attack and queued_attack:
		var direction = player.get_movement_direction()
		finished.emit(next_attack.name, {"direction" : direction})
