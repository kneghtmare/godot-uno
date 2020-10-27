extends Control
class_name GameManager

var is_player1s_turn := true

onready var player1CardContainer: GridContainer = $Player1CardContainer
onready var player2CardContainer: GridContainer = $Player2CardContainer


func get_turn_card_container() -> GridContainer:
	if is_player1s_turn:
		return player1CardContainer
	
	return player2CardContainer


func switch_turn() -> void:
	is_player1s_turn = not is_player1s_turn
