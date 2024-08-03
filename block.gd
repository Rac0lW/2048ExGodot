extends Node2D
class_name Block

var value:int = 2
var gridPosition:Vector2
var isDie:bool = false
@onready var icon = $Icon
@onready var color_rect = $Icon/ColorRect
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

@onready var label = $Label

func readyToDie():
	isDie = true

func New(pos):
	pass
	
func Delete():
	erase()

func movePosition(from, to, width):
	pass

func getPos() -> Vector2:
	return gridPosition

func setGlobalPostion(pos, width):
	gridPosition = pos
	if not is_inside_tree():
		position = pos * width
		return
	var tween = get_tree().create_tween()
	audio_stream_player_2d.play()
	tween.tween_property(self, "position", pos * width, 0.5).set_trans(Tween.TRANS_QUAD)
	if isDie:
		Delete()
	
func setDefault():
	pass

func getValue() -> int:
	return value
	
func mergeValue():
	value += value
	label.text = str(value)
	#TODO use shader to make it, value is named "intensity" 
	if not is_inside_tree():
		return
	var tween = get_tree().create_tween()
	tween.tween_property(icon, "scale", Vector2(1.2, 1.2), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(icon, "scale", Vector2(1.0, 1.0), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	
func erase():
	queue_free()
