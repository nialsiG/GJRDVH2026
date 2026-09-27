extends Node

# Start with neutral state
var state: EnumCollection.EKarma = EnumCollection.EKarma.Neutral

# Counters
var wise_points = 0
var evil_points = 0

func add_wise_points(points: int):
	wise_points += points

func add_evil_points(points: int):
	evil_points += points

func change_state(new_state: EnumCollection.EKarma):
	state = new_state
