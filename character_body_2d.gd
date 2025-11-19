extends CharacterBody2D
class_name Player

@export_category("Stats")
@export var move_speed: float

@export_category("State Machine")
@export var state: states = states.IDLE

@export_category("Node References")
@export var sprite: AnimatedSprite2D

enum states {
	IDLE,
	WALK
}

var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

func initialize() -> void:
	
	pass
	
func connect_signals() -> void:
	
	pass
	
func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	
	match state:
		states.IDLE:
			idle()
		states.WALK:
			walk()

#region State Machine
func change_state(new_state: states, animation: String = "idle") -> void:
	state = new_state
	sprite.play(animation)

func idle() -> void:
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		change_state(states.WALK, "walk")

func walk() -> void:
	velocity = direction * move_speed
	move_and_slide()
	
	if direction == Vector2.ZERO:
		change_state(states.IDLE, "idle")


#endregion
