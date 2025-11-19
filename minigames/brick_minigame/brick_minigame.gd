extends Node2D

@export var done_button: Button

var all_positions
var remaining_positions
var filled_positions
var unused_bricks

func _ready() -> void:
	initialize()
	
func initialize() -> void:
	connect_signals()

func connect_signals() -> void:
	done_button.pressed.connect(end_game)
	
func end_game() -> void:
	
	pass
