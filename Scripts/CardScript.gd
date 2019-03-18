extends TextureButton

signal select

var context = ""
var state = 0;

func _ready():
	self.connect("pressed", self, "_on_pressed")
	
func _process(delta):
	var move = Vector2(1, 0)

func on_release():
	self.use_parent_material = true;

func on_select():
	self.use_parent_material = false;

func _on_pressed():
	var id = int(self.name.split("d")[1])
	emit_signal("select", id - 1)

func setContext(var con):
	context = con;

func getContext():
	return context