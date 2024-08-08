extends Node

@onready var bm = get_tree().get_first_node_in_group("bm")

func _ready():
	pass

func _process(_delta):

	if Input.is_action_just_pressed("MOUSE_LEFT"):
		var pos = get_viewport().get_mouse_position()
		for i in bm.get_children():
			if i.isInRect(pos - i.global_position):
				print(i.name)
			
