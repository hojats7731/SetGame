extends Label

var timer
var remain = 300

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "on_tick")
	timer.start()

func on_tick():
	remain -= 1;
	if(remain < 0):
		return
	if(remain == 0):
		self.text = "Time: " + str(remain/60) + ":00"
		var scoreSceneRes = load("res://Scenes/ScoreScene.tscn")
		var scoreScene = scoreSceneRes.instance()
		get_parent().add_child(scoreScene)
	elif(remain%60 < 10):
		self.text = "Time: " + str(remain/60) + ":0" + str(remain%60) 
	else:
		self.text = "Time: " + str(remain/60) + ":" + str(remain%60) 
	pass

