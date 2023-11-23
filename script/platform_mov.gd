extends Node2D

const WAIT_DURATION := 1.0

@onready var platform := $plaform as AnimatableBody2D
@export var move_speed := 10.0
@export var distance := 192
@export var move_horizontal := true

var follow := Vector2.ZERO
var platform_center := 16
var move_direction := Vector2.RIGHT  # Inicia movendo para a direita
var time_elapsed := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	move_platform()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	platform.position = platform.position.lerp(follow, 1.0)
	time_elapsed += delta

	if time_elapsed >= WAIT_DURATION:
		time_elapsed = 0.0
		move_direction = -move_direction  # Inverte a direção após o tempo de espera
		move_platform()

func move_platform():
	var move_distance = distance if move_horizontal else distance
	var move_vector = move_direction * move_distance
	var duration = move_vector.length() / float(move_speed * platform_center)
	
	var platform_tween = create_tween()
	platform_tween.tween_property(self, "follow", platform.position + move_vector, duration)
