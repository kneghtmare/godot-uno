extends CenterContainer
class_name Card

var is_being_dragged := false

func _ready() -> void:
	connect("gui_input", self, "_on_gui_input")

func _process(delta: float) -> void:
	if is_being_dragged:
		rect_position = get_global_mouse_position()

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		is_being_dragged = true
		
	if event.is_action_released("drag"):
		is_being_dragged = false
