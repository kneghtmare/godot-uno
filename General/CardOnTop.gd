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


func display_correct_color() -> void:
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


func can_drop_data(_position: Vector2, data):
	return data is Dictionary and data.has("number")


func drop_data(position: Vector2, data):
	color = data.color
	display_correct_color()
	numberLabel.text = str(data.number)