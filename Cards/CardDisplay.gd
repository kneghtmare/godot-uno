extends CenterContainer
class_name CardDisplay

enum Colors {
	RED,
	YELLOW,
	GREEN,
	BLUE
}

export var number := 0
export (Colors) var color

var card := Card.new()
var is_being_dragged := false

onready var colorRect: ColorRect = $ColorRect
onready var numberLabel: Label = $NumberLabel


func _ready() -> void:
	card.color = color
	card.number = number
	
	update_display()


func _process(delta: float) -> void:
	if is_being_dragged:
		rect_position = get_global_mouse_position()
	

#displays proper color that was exported
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
	

func get_drag_data(_position: Vector2) -> Dictionary:
	var data := {}
	data.card_display = self
	data.card = card
	var dragPreview := ColorRect.new()
	dragPreview.rect_size = colorRect.rect_size
	dragPreview.color = colorRect.color
	set_drag_preview(dragPreview)
	return data
