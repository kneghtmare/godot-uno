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

onready var colorRect := $ColorRect
onready var numberLabel := $NumberLabel

func _ready() -> void:
	update_display()


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
	

func can_drop_data(_position: Vector2, data) -> bool:
	return data is Dictionary and data.has("number")
	
	
func drop_data(position: Vector2, data):
	if data.color_rect_color == colorRect.color or data.number == number:
		color = data.color
		update_display()
		data.card.queue_free()
