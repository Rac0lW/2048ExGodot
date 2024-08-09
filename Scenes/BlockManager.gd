extends Node2D

class_name BlockManager

@onready var main = $".."
@onready var init_settings = $"../InitSettings"
@onready var l_timer = $"../LTimer"

var rows:int
var cols:int
var width:int


var newBlock = preload("res://Scenes/block.tscn")
var gridTable = Dictionary()



func _ready():
	valueInitial()
	genStart()
	
func _process(delta):
	checkisLost()
	
func checkisLost():
	if get_child_count() >= 16:
		pass
	#TODO lose animation
	
func valueInitial():
	rows = init_settings.rows
	cols = init_settings.cols
	width = init_settings.width

func genStart():
	gen4RandomBlock()

func gen4RandomBlock() -> void:
	generateRandomBlock()
	generateRandomBlock()
	generateRandomBlock()
	generateRandomBlock()
	
func generateRandomBlock():
	var pos = Vector2(randi_range(0, rows - 1), randi_range(0, cols - 1))
	while(gridTable.has(pos)):
		pos = Vector2(randi_range(0, rows - 1), randi_range(0, cols - 1))
	generateBlock(pos)
	
func generateBlock(pos: Vector2):
	var blockInstance = newBlock.instantiate()
	blockInstance.setGlobalPostion(pos, width)
	gridTable[pos] = true
	add_child(blockInstance)
	#TODO add some animation for the generation
	
func _on_input_gen():
	l_timer.start()
	#await timer.timeout
func _on_timer_timeout():
	generateRandomBlock()

func _on_check_button_pressed():
	freeTable()
	freeChildren()
	restart()
	print("Restart")

func freeTable():
	gridTable.clear()

func freeChildren():
	for i in get_children():
		i.queue_free()

func restart():
	gen4RandomBlock()
