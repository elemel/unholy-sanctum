extends Area2D
class_name Torch

@export var speed = 100.0
@export var life_duration = 3.0
@export var rotation_speed = 5.0
@export var rotation_phase_degrees = -45.0
@export var min_damage = 10.0
@export var max_damage = 20.0
@export var unit_radius = 5.0

var creation_time = 0.0
var velocity = Vector2.ZERO
var z = -45.0
var velocity_z = -20.0
var acceleration_z = 50.0
var thrower: Node2D

@onready var sprite = $"Sprite2D"
@onready var shadow_sprite = $"Shadow/Sprite2D"

func _ready():
    creation_time = 0.001 * Time.get_ticks_msec()
    body_entered.connect(_on_body_entered)

    sprite.position.y = z
    shadow_sprite.position.y = z

func _physics_process(delta: float) -> void:
    var now = 0.001 * Time.get_ticks_msec()

    if now - creation_time > life_duration:
        queue_free()
        return

    velocity_z += acceleration_z * delta
    z += velocity_z * delta

    if z > 0.0:
        queue_free()
        return

    position += velocity * delta

func _process(_delta: float) -> void:
    var now = 0.001 * Time.get_ticks_msec()

    var direction = -1.0 if velocity.x < 0.0 else 1.0
    var sprite_rotation = ((now - creation_time) * rotation_speed + deg_to_rad(rotation_phase_degrees)) * direction

    sprite.position.y = z
    sprite.rotation = sprite_rotation

    shadow_sprite.position.y = z
    shadow_sprite.rotation = sprite_rotation

    z_index = int(position.y)

func _on_body_entered(body: Node2D) -> void:
    if body != thrower:
        if body.has_method("receive_damage"):
            var damage = randf_range(min_damage, max_damage)
            body.receive_damage(damage)
            queue_free()
            return
