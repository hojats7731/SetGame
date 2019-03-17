extends TextureButton

signal select

var context = ""

func _ready():
	self.connect("pressed", self, "_on_pressed")

func _on_pressed():
	var id = int(self.name.split("d")[1])
	#print(id)
	emit_signal("select", id - 1)

func setContext(var con):
	context = con;

func getContext():
	return context