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
onready var gameManager: GameManager = $"/root/Game"


func _ready() -> void:
	card.color = color
	card.number = number
	
	update_display()


func can_play() -> bool:
	if "Player1" in get_parent().name:
		return gameManager.is_player1s_turn
	elif "Player2" in get_parent().name:
		return not gameManager.is_player1s_turn
		
	return false
	

#displays proper color that was exported
func update_display() -> void:
	var color_dictionary := {
		Colors.RED : Color.red,
		Colors.BLUE : Color.blue,
		Colors.YELLOW : Color.yellow,
		Colors.GREEN : Color.green
	}
	
	colorRect.color = color_dictionary[card.color]
			
	numberLabel.text = str(card.number)
	

func get_drag_data(_position: Vector2) -> Dictionary:
	if can_play():
		var data := {}
		data.card_display = self
		data.card = card
		var dragPreview := ColorRect.new()
		dragPreview.rect_size = colorRect.rect_size
		dragPreview.color = colorRect.color
		set_drag_preview(dragPreview)
		return data
	
	return {}
