extends Enemy

const ENEMY_PROJECTILE = preload("uid://0qtans3shtxh")

@export var attack_bone: BoneAttachment3D

func _on_weapon_slot_ranged_attack() -> void:
	var projectile = ENEMY_PROJECTILE.instantiate()
	add_child(projectile)
	projectile.global_position = attack_bone.global_position
	projectile.global_rotation.y = global_rotation.y
