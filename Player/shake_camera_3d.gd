extends Camera3D

@export var noise: FastNoiseLite
@export var trauma: float = 0.0
@export var offset_scale: float = 1.0
@export var shake_duration: float = 0.5

func _physics_process(delta: float) -> void:
	var time = Time.get_ticks_msec()
	h_offset = noise.get_noise_2d(time, 0.0) * trauma * offset_scale
	v_offset = noise.get_noise_2d(0.0, time) * trauma * offset_scale
	
func quick_shake(magnitude: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "trauma", 0.0, shake_duration).from(magnitude)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		quick_shake(1.0)
