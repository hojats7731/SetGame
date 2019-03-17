extends Panel

var selectedCardSize = 0
var state = []
var cards = []

func _ready():
	addCards()
	showCards()
	for i in range(21):
		get_tree().get_nodes_in_group("Cards")[i].connect("select", self, "_on_card_pressed")
		state.push_back(false);


func _on_card_pressed(var num):
	print(num)
	state[num] = !state[num]
	if state[num]:
		selectedCardSize += 1
		if selectedCardSize == 3:
			var isSet = checkSet()
			if(isSet):
				setFound()
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
		get_node("Card" + str(i+1)).set_normal_texture(load("res://Sprites/Cards/" + str(cards[i]) + ".png"))
		cards.pop_front()
	

func checkSet():
	var selectedCards = []
	var j = 0
	for i in range(21):
		if state[i] :
			selectedCards[j]
			j += 1
	
	var isSet = false
	var count = []
	
	for i in range(4):
		for j in range(3):
			var n = selectedCards[j] % pow(10, i+1)
			count[n] += 1
		
		if(count[0] * count[1] * count[2] == 1):
			isSet = true
		elif(count[0] == 3 || count[1] == 3 || count[2] == 3):
			isSet = true
	return isSet


func setFound():
	print("hi")
	pass

