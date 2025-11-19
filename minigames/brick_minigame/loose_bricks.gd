extends Node2D
class_name LooseBricks

var remaining_bricks: Array[Brick]

func initialize() -> void:
	for i in get_children():
		remaining_bricks.append(i)
	connect_signals()
	
func connect_signals() -> void:
	for i in remaining_bricks:
		i.brick_placed.connect(brick_placed)
		i.brick.removed.connect(brick_removed)

func brick_placed(id: Brick) -> void:
	remaining_bricks.erase(id)
	
func brick_removed(id: Brick) -> void:
	remaining_bricks.append(id)
