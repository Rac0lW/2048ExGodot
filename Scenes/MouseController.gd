extends Node

@onready var bm:BlockManager = get_tree().get_first_node_in_group("bm")

var cb:Block

var isAbleToMove:bool = false

func _ready():
	pass

func _process(_delta):

	if Input.is_action_just_pressed("MOUSE_LEFT"):
		var pos = get_viewport().get_mouse_position()
		for i in bm.get_children():
			if i.isInRect(pos - i.global_position):
				cb = i
				cb.SelectToggle()
				cb.lastPos = cb.global_position
				
	
	if Input.is_action_just_released("MOUSE_LEFT") and cb:
		if isAbleToMove:
			#bm.gridTable.erase(cb.getPos())
			pass
			
			#TODO: Update the gridTable and Block's settings
		else:
			cb.SelectToggle()
			cb.global_position = cb.lastPos
			


