extends Area3D

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body: Node3D) -> void:
	if body.has_node("HealthComponent"):
		var health_component = body.get_node("HealthComponent") as HealthComponent
		if health_component:
			health_component.take_damage(health_component.max_health)
