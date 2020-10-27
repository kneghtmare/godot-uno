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


#displays proper color that was exported
func update_display() -> void:
	var color_dictionary := {
		Colors.RED : Color.red,
		Colors.BLUE : Color.blue,
		Colors.YELLOW : Color.yellow,
		Colors.GREEN : Color.green
	}
	
	colorRect.color = color_dictionary[color]
			
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
