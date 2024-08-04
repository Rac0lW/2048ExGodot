extends Node2D
class_name Block

var value:int = 2
var gridPosition:Vector2
var isDie:bool = false
@onready var icon = $Icon
@onready var color_rect = $Icon/ColorRect
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
#@onready var label = $Label
@onready var label = $Icon/ColorRect/Label
@onready var audio_stream_player_2d_2 = $AudioStreamPlayer2D2


#@onready var label = $Label

func _ready():
	var temp = 1 - float(value) / 2048. 
	var rtemp = 1 - temp
	color_rect.set_color(Color(temp, temp, temp, 1))
	label.set("theme_override_colors/font_color", Color(rtemp, rtemp, rtemp, 1.0))
	

func readyToDie():
	isDie = true

func Delete():
	erase()

func getPos() -> Vector2:
	return gridPosition

func setGlobalPostion(pos, width):
	gridPosition = pos
	if not is_inside_tree():
		position = pos * width
		return
	var tween = get_tree().create_tween()
	audio_stream_player_2d_2.play()
	tween.tween_property(self, "position", pos * width, 0.5).set_trans(Tween.TRANS_QUAD)
	if isDie:
		Delete()
		
func getValue() -> int:
	return value
	
func mergeValue():
	VCFChange()
	mergeAnimationPlay()
	
func VCFChange():
	value += value
	label.text = str(value)
	var temp = 1 - float(value) / 2048. 
	var rtemp = - temp
	color_rect.set_color(Color(temp, temp, temp, 1))
	label.set("theme_override_colors/font_color", Color(rtemp, rtemp, rtemp, 1.0))
	
	if value == 1024 or value == 2048:
		label.set("theme_override_font_sizes/font_size", 48)

func mergeAnimationPlay():
	if not is_inside_tree():
		return
	var tween = get_tree().create_tween()
	audio_stream_player_2d.play()
	tween.tween_property(icon, "scale", Vector2(1.2, 1.2), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "scale", Vector2(1.1, 1.1), 0.07).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "scale", Vector2(1.0, 1.0), 0.07).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(icon, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
func erase():
	queue_free()
