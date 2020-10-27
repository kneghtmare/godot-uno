extends CenterContainer
class_name CardOnTop

enum Colors {
	RED,
	YELLOW,
	GREEN,
	BLUE
}

export var number := 0
export (Colors) var color
var card := Card.new()

onready var colorRect := $ColorRect
onready var numberLabel := $NumberLabel

func _ready() -> void:
	OS.center_window()
	card.color = color
	card.number = number
	update_display()


func update_display() -> void:
	var color_dictionary := {
		Colors.RED : Color.red,
		Colors.BLUE : Color.blue,
		Colors.YELLOW : Color.yellow,
		Colors.GREEN : Color.green
	}
	
	colorRect.color = color_dictionary[card.color]
	
	numberLabel.text = str(card.number)
	

func can_drop_data(_position: Vector2, data) -> bool:
	var is_data_valid: bool = data is Dictionary and data.has("card")
	if is_data_valid:
		#only can drop data if the color or number matches
		if data.card.color == card.color or data.card.number == card.number:
			return true
		
	return false
	
	
func drop_data(_position: Vector2, data):
	card.color = data.card.color
	card.number = data.card.number
	update_display()
	data.card_display.queue_free()

