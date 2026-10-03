extends Node

var state: EnumCollection.EKarma
var choices_made: Array[EnumCollection.EChoice]

# Counters
var wise_points
var evil_points

func _ready() -> void:
	SignalManager.NewGame.connect(on_new_game)

func on_new_game() -> void:
	state = EnumCollection.EKarma.NEUTRAL
	choices_made = [EnumCollection.EChoice.NONE]
	wise_points = 0
	evil_points = 0

func add_wise_points(points: int):
	wise_points += points
	if wise_points > evil_points:
		state = EnumCollection.EKarma.WISE
	print("WISE POINTS ADDED=", wise_points)

func add_evil_points(points: int):
	evil_points += points
	if evil_points > wise_points:
		state = EnumCollection.EKarma.EVIL
	print("EVILS POINTS ADDED=", evil_points)

func change_state(new_state: EnumCollection.EKarma):
	state = new_state

func add_choice(choice: EnumCollection.EChoice):
	if !choices_made.has(choice):
		choices_made.append(choice)
		SignalManager.ChoiceIsMade.emit(choice)
