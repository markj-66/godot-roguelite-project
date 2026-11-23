extends CharacterBody3D
class_name Enemy

@export var base_speed := 3.5
@export var stun_state: EnemyState
@export var defeat_state: EnemyState

@onready var animation_tree: AnimationTree = $AnimationAnchor/AnimatedEnemy/Enemy_Medium/AnimationTree
@onready var state_machine: StateMachine = $StateMachine
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func _on_health_component_health_changed(value: Variant) -> void:
	state_machine.state.finished.emit(stun_state.name)

func _on_health_component_defeat() -> void:
	state_machine.state.finished.emit(defeat_state.name)
	collision_shape_3d.set_deferred("disabled", true)
