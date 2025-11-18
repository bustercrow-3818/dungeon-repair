extends Sprite2D
class_name Brick

@export_category("Node References")
@export var mouse_area: Area2D
@export var placement_area: Area2D
@export var brick_bounds: CollisionShape2D

@export_category("State Machine")
@export var state: states

@export_category("Parameters")
@export var grab_scatter_range: Vector2
@export var drop_scatter_range: Vector2
@export var drop_scatter_time: float

var mouse_in_area: bool = false
var legal_positions: Array[Area2D]
var bounds: Rect2
var drag_offset: Vector2

enum states {
	IDLE,
	DRAG,
	PLACED,
	LOCKED
}

func _ready() -> void:
	initialize()
	
func _physics_process(_delta: float) -> void:
	match state:
		states.IDLE:
			idle()
		states.DRAG:
			drag()
		states.PLACED:
			placed()
		states.LOCKED:
			locked()
	
func initialize() -> void:
	connect_signals()
	
func connect_signals() -> void:
	mouse_area.mouse_entered.connect(mouse_entered)
	mouse_area.mouse_exited.connect(mouse_exited)

func change_state(new_state: states) -> void:
	
	state = new_state

func idle() -> void:
	if Input.is_action_just_pressed("click") and mouse_in_area == true:
		bounds = Rect2(0,0,0,0)
		drag_offset = Vector2(randf_range(grab_scatter_range.x, grab_scatter_range.y), randf_range(grab_scatter_range.x, grab_scatter_range.y))
		change_state(states.DRAG)
	else:
		pass
	
func drag() -> void:
	global_position = get_global_mouse_position() + drag_offset
	
	if Input.is_action_just_released("click"):
		var check_areas: Array[Area2D]
		
		for i in placement_area.get_overlapping_areas():
			if i.is_in_group("legal_position"):
				check_areas.append(i)
		
		if check_areas.is_empty():
			var tween = create_tween()
			tween.tween_property(self, "global_position", global_position + Vector2(randf_range(drop_scatter_range.x, drop_scatter_range.y), randf_range(drop_scatter_range.x, drop_scatter_range.y)), drop_scatter_time)
			change_state(states.IDLE)
		else:
			global_position = check_areas[0].global_position
			change_state(states.PLACED)
	
func placed() -> void:
	if Input.is_action_just_pressed("click") and mouse_in_area == true:
		bounds = Rect2(0,0,0,0)
		change_state(states.DRAG)

func locked() -> void:
	pass

func mouse_entered() -> void:
	mouse_in_area = true

func mouse_exited() -> void:
	mouse_in_area = false
