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

onready var colorRect := $ColorRect
onready var numberLabel := $NumberLabel
onready var cardGridContainer = get_node(card_grid_container_path)


func _ready() -> void:
	change_card()
	update_card()
	connect("gui_input", self, "_on_gui_input")
	

func update_card() -> void:
	match color:
		Colors.RED:
			colorRect.color = Color.red
		Colors.BLUE:
			colorRect.color = Color.blue
		Colors.YELLOW:
			colorRect.color = Color.yellow
		Colors.GREEN:
			colorRect.color = Color.green
		_: #if color is somehow none of the above values, set color to white
			colorRect.color = Color.white
	
	numberLabel.text = str(number)
	

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var newCard = cardScene.instance()
			newCard.number = self.number
			newCard.color = self.color
			cardGridContainer.add_child(newCard)
			change_card()
			update_card()
			

func change_card() -> void:
	var random_color = available_colors[randi() % available_colors.size()]
	var random_number = available_numbers[randi() % available_numbers.size()]
	
	color = random_color
	number = random_number
	
	var card_data := {
		"number": random_number,
		"color" : random_color
	}
	
	done_cards.append(card_data)
