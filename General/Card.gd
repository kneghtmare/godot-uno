extends CenterContainer
class_name Card

enum Colors {
	RED,
	YELLOW,
	GREEN,
	BLUE
}

export var number := 0
export (Colors) var color
var is_being_dragged := false

onready var colorRect: ColorRect = $ColorRect
onready var numberLabel: Label = $NumberLabel


func _ready() -> void:
	display_correct_color()
	numberLabel.text = str(number)


func _process(delta: float) -> void:
	if is_being_dragged:
		rect_position = get_global_mouse_position()


#displays proper color that was exported
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


func get_drag_data(_position: Vector2) -> Dictionary:
	var data := {}
	data.number = number
	data.color = color
	var dragPreview := ColorRect.new()
	dragPreview.rect_size = colorRect.rect_size
	dragPreview.color = colorRect.color
	set_drag_preview(dragPreview)
	return data
