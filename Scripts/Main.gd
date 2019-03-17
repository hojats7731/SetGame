extends Panel

signal score

var selectedCardSize = 0
var state = []
var cards = []

func _ready():
	addCards()
	showCards()
	self.connect("score", $Score, "on_score")
	for i in range(21):
		get_tree().get_nodes_in_group("Cards")[i].connect("select", self, "_on_card_pressed")
		state.push_back(false);


func _on_card_pressed(var num):
	print("Select")
	state[num] = !state[num]
	if state[num]:
		selectedCardSize += 1
		if selectedCardSize == 3:
			var isSet = checkSet()
			if(isSet):
				setFound()
			else:
				emit_signal("score", -5)
	else: 
		selectedCardSize += 1

func addCards():
	for i in range(81):
		cards.push_back(get3Basis(i))

func get3Basis(var n):
	var number = ""
	for i in range(4):
		number = str(n%3) + number
		n /= 3
	return number

func showCards():
	cards.shuffle()
	for i in range(21):
		get_node("Card" + str(i+1)).set_normal_texture(load("res://Sprites/Cards/" + cards[i] + ".png"))
		get_node("Card" + str(i+1)).setContext(cards[i])
		cards.erase(cards[i])
	

var selectedCards = []
var selectedIds = []
func checkSet():
	var j = 0
	selectedCards.clear()
	selectedIds.clear()
	for i in range(21):
		if state[i] :
			selectedIds.push_back("Card" + str(i+1))
			selectedCards.push_back(get_node("Card" + str(i+1)).getContext())
			j += 1
	
	var isSet = 0
	var count = [0, 0, 0]
	
	for i in range(4):
		for j in range(3):
			var n = int(selectedCards[j].substr(i, 1))
			count[n] += 1
		
		if(count[0] * count[1] * count[2] == 1):
			isSet += 1
		elif(count[0] == 3 || count[1] == 3 || count[2] == 3):
			isSet += 1
		count = [0, 0, 0]
	
	for i in range(21):
		get_tree().get_nodes_in_group("Cards")[i].connect("select", self, "_on_card_pressed")
		state.push_back(false);
	print("Released")
	selectedCardSize = 0;
	return isSet == 4


func setFound():
	print("Set Found!")
	emit_signal("score", 10)
	for i in range(3):
		cards.push_back(selectedCards[i])
	cards.shuffle()
	for i in range(3):
		get_node(selectedIds[i]).set_normal_texture(load("res://Sprites/Cards/" + cards[i] + ".png"))
		get_node(selectedIds[i]).setContext(cards[i])
		cards.erase(cards[i])

