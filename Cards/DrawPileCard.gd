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
var cardScene := preload("res://Cards/Card.tscn")

onready var colorRect := $ColorRect
onready var numberLabel := $NumberLabel
onready var cardGridContainer = get_node(card_grid_container_path)


func _ready() -> void:
	update_display()
	connect("gui_input", self, "_on_gui_input")
	

func update_display() -> void:
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
