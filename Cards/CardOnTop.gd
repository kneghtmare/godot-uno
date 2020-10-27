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
	card.color = color
	card.number = number
	update_display()


func update_display() -> void:
	match card.color:
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
	
	numberLabel.text = str(card.number)
	

func can_drop_data(_position: Vector2, data) -> bool:
	var is_data_valid: bool = data is Dictionary and data.has("card")
	if is_data_valid:
		#only can drop data if the color or number matches
		return data.card.color == card.color or data.card.number == card.number
		
	return false
	
	
func drop_data(_position: Vector2, data):
	if data.card.color == card.color or data.card.number == card.number:
		card.color = data.card.color
		card.number = data.card.number
		update_display()
		data.card_display.queue_free()
	
