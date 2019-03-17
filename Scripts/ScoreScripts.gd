extends Label

var score = 0

func _ready():
	pass
	
func on_score(s):
	score += s
	self.text = "Score: " + str(score)
	pass


