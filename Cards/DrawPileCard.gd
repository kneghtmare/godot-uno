extends CenterContainer
class_name DrawPileCard

enum Colors {
	RED,
	YELLOW,
	GREEN,
	BLUE
}

export var number := 0
export (Colors) var color
export var card_grid_container_path: NodePath

#preloads
var cardScene := preload("res://Cards/Card.tscn")

var available_colors = [Colors.RED, Colors.YELLOW, Colors.GREEN, Colors.BLUE]
var available_numbers = [0,1,2,3,4,5,6,7,8,9]
var done_cards := []
var card := Card.new()

onready var colorRect := $ColorRect
onready var numberLabel := $NumberLabel
onready var cardGridContainer = get_node(card_grid_container_path)


func _ready() -> void:
	card = make_new_card()
	update_display()
	connect("gui_input", self, "_on_gui_input")
	

func update_display() -> void:
	var color_dictionary := {
		Colors.RED : Color.red,
		Colors.BLUE : Color.blue,
		Colors.YELLOW : Color.yellow,
		Colors.GREEN : Color.green
	}
	
	colorRect.color = color_dictionary[card.color]
	
	numberLabel.text = str(card.number)
	

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			#makes a new card, sets it number and color to our own card
			var newCard = cardScene.instance()
			newCard.number = card.number
			newCard.color = card.color
			#adds it as a child of the gridContainer
			cardGridContainer.add_child(newCard)
			#changes the card
			card = make_new_card()
			update_display()
			

func make_new_card() -> Card:
	var card = Card.new()
	var random_color = available_colors[randi() % available_colors.size()]
	var random_number = available_numbers[randi() % available_numbers.size()]
	
	card.color = random_color
	card.number = random_number
	
	done_cards.append(card)
	return card
