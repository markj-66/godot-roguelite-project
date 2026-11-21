extends Node3D

@export var health_component: HealthComponent
@export var health_color: Color

@onready var front_progress_bar: ProgressBar = $SubViewport/FrontProgressBar
@onready var health_progress_bar: ProgressBar = $SubViewport/HealthProgressBar

func _ready() -> void:
	health_component.health_changed.connect(update_health_value)
	front_progress_bar.value = 100.0
	front_progress_bar.get_theme_stylebox("fill").bg_color = health_color
	
func update_health_value(value_in: float) -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	var target_health_percentage= (value_in / health_component.max_health) * 100.0
	tween.tween_property(health_progress_bar, "value", target_health_percentage, 0.2).from(front_progress_bar.value)
	front_progress_bar.value = target_health_percentage
	
