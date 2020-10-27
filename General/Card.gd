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
	connect("gui_input", self, "_on_gui_input")
	display_correct_color()
	numberLabel.text = str(number)

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
		_:
			colorRect.color = Color.white


func _process(delta: float) -> void:
	if is_being_dragged:
		rect_position = get_global_mouse_position()


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		is_being_dragged = true
		
	if event.is_action_released("drag"):
		is_being_dragged = false
