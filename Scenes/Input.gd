extends Node
signal gen
@onready var init_settings = $"../InitSettings"
@onready var block_manager = $"../BlockManager"
@onready var main = $".."
@onready var timer = $Timer

var flag:bool = true
var RIGHT = Vector2(1, 0)
var LEFT = Vector2(-1, 0)
var DOWN = Vector2(0, 1)
var UP = Vector2(0, -1)

var dir = Vector2(0, 0)


func _process(delta):
	control()
			
func control():
	var a = block_manager.get_children()
	if flag:
		if Input.is_action_just_pressed("RIGHT"):
			timer.start()
			flag = false
			dir = RIGHT
			a.sort_custom(func(a, b): return a.getPos().x > b.getPos().x)
			for t in a:
				var temp = getLastEmptyBlock(t, dir)
				t.setGlobalPostion(getLastEmptyBlock(t, dir), init_settings.width)
				block_manager.gridTable[temp] = true
			gen.emit()
		if Input.is_action_just_pressed("LEFT"):
			timer.start()
			flag = false
			dir = LEFT
			a.sort_custom(func(a, b): return a.getPos().x < b.getPos().x)
			for t in a:
				var temp = getLastEmptyBlock(t, dir)
				t.setGlobalPostion(getLastEmptyBlock(t, dir), init_settings.width)
				block_manager.gridTable[temp] = true
			gen.emit()
		if Input.is_action_just_pressed("DOWN"):
			timer.start()
			flag = false
			dir = DOWN
			a.sort_custom(func(a, b): return a.getPos().y > b.getPos().y)
			for t in a:
				var temp = getLastEmptyBlock(t, dir)
				t.setGlobalPostion(getLastEmptyBlock(t, dir), init_settings.width)
				block_manager.gridTable[temp] = true
			gen.emit()
		if Input.is_action_just_pressed("UP"):
			timer.start()
			flag = false
			dir = UP
			a.sort_custom(func(a, b): return a.getPos().y < b.getPos().y)
			for t in a:
				var temp = getLastEmptyBlock(t, dir)
				t.setGlobalPostion(getLastEmptyBlock(t, dir), init_settings.width)
				block_manager.gridTable[temp] = true
			gen.emit()
		
		

	

func getLastEmptyBlock(t, dir):
	var flag:Vector2 = t.getPos()
	
	if dir == RIGHT:
		flag += dir
		while flag.x < init_settings.cols and not block_manager.gridTable.get(flag):
			flag += dir
			
	if dir == LEFT:
		flag += dir
		while flag.x >= 0 and not block_manager.gridTable.get(flag):
			flag += dir
			
	if dir == UP:
		flag += dir
		while flag.y >= 0 and not block_manager.gridTable.get(flag):
			flag += dir
			
	if dir == DOWN:
		flag += dir
		while flag.y < init_settings.rows and not block_manager.gridTable.get(flag):
			flag += dir
	
	block_manager.gridTable.erase(t.getPos())
	
	
	if isReadyToMerge(t, flag):
		Merge(t, flag)
		block_manager.gridTable.erase(t.getPos())
		t.readyToDie()
		return flag
	
	#block_manager.gridTable[flag - dir] = true
	
	return flag - dir
	
func Merge(t, flag):
	for i in block_manager.get_children():
		if i.getPos() == flag:
			i.mergeValue()
			

func isReadyToMerge(t, flag)-> bool:
	for i in block_manager.get_children():
		if i.getPos() == flag:
			if i.getValue() == t.getValue():
				return true
	return false

func _on_timer_timeout():
	flag = true
