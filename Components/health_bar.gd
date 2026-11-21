extends Node3D

@export var health_component: HealthComponent

@onready var front_progress_bar: ProgressBar = $SubViewport/FrontProgressBar

func _ready() -> void:
	health_component.health_changed.connect(update_health_value)
	
func update_health_value(value_in: float) -> void:
	front_progress_bar.value = (value_in / health_component.max_health) * 100.0
