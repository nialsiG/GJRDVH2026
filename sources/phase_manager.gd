extends Node

enum EPhaseState {
	START,
	CHOICE,
}

const ON_START_DIALOGUE = preload("uid://f66fq3pqvoso")

const COLLINE_START_DIALOGUES = preload("uid://d3apeedp848o4")
const COLLINE_CHOICE_DIALOGUES = preload("uid://b8gmbkkxkshpx")

const ALLIEES_START_DIALOGUES_SAGE = preload("uid://yfpqyikr7sxy")
const ALLIEES_START_DIALOGUES_CHAOS = preload("uid://0uskebnyvsre")
const ALLIEES_CHOICE_DIALOGUES = preload("uid://yd345vtmbnmi")

const ARBRE_START_DIALOGUES_SAGE = preload("uid://bg3gsaev6rnoo")
const ARBRE_START_DIALOGUES_CHAOS = preload("uid://jgctj6nadeb6")
const ARBRE_CHOICE_DIALOGUES = preload("uid://dvin46hvbjtts")

const ANIMAL_START_DIALOGUES_SAGE = preload("uid://blhnn0v8ak5b5")
const ANIMAL_START_DIALOGUES_CHAOS = preload("uid://ffu6k5632fh")
const ANIMAL_CHOICE_DIALOGUES = preload("uid://be7idtjkjbtfu")

const FRERES_START_DIALOGUES_SAGE = preload("uid://cgv63p7x8wae5")
const FRERES_START_DIALOGUES_CHAOS = preload("uid://b2o0ga517rvxv")
const FRERES_CHOICE_DIALOGUES = preload("uid://bud10cmwur2sx")

var end_phase: bool = true
var current_phase: EnumCollection.EPhase
var current_state: EPhaseState = EPhaseState.START:
	set(new_state):
		current_state = new_state
		var dialogues: Array[DialogueResource] = _GetDialoguesFromPhaseAndState()
		SignalManager.NewDialogueArray.emit(dialogues)

func _ready():
	SignalManager.NewGame.connect(Reset)
	SignalManager.ChoiceIsMade.connect(OnChoiceIsMade)

func Reset():
	_ChangePhase(EnumCollection.EPhase.START)

func NextPhase():
	print("NextPhase")
	if current_phase == EnumCollection.EPhase.FRERES:
		SignalManager.GameOver.emit()
		print("GAME OVER!")
	else:
		_ChangePhase(current_phase + 1)

func NextState():
	print("NextState")
	if current_state == EPhaseState.START:
		current_state = EPhaseState.CHOICE
	else:
		current_state = EPhaseState.START

func OnChoiceIsMade(_choice: EnumCollection.EChoice):
	print("end_phase = true")
	end_phase = true

func OnDialogueIsEnded():
	if current_phase == EnumCollection.EPhase.START || end_phase == true:
		NextPhase()
	NextState()

func _ChangePhase(phase: EnumCollection.EPhase):
	current_phase = phase
	current_state = EPhaseState.START
	end_phase = false
	SignalManager.OnNextPhase.emit(phase)

func _GetDialoguesFromPhaseAndState() -> Array[DialogueResource]:
	if current_phase == EnumCollection.EPhase.START:
		print("start_dialogues")
		return ON_START_DIALOGUE.dialog_resources
	elif current_phase == EnumCollection.EPhase.COLLINE:
		if current_state == EPhaseState.START:
			print("colline_start_dialogues")
			return COLLINE_START_DIALOGUES.dialog_resources
		elif current_state == EPhaseState.CHOICE:
			print("colline_choice_dialogues")
			return COLLINE_CHOICE_DIALOGUES.dialog_resources
	elif current_phase == EnumCollection.EPhase.ALLIES:
		print("alliees_phase_dialogues")
		if current_state == EPhaseState.START:
			print("alliees_phase_start_dialogues")
			if KarmaManager.state == EnumCollection.EKarma.WISE:
				return ALLIEES_START_DIALOGUES_SAGE.dialog_resources
			else:
				return ALLIEES_START_DIALOGUES_CHAOS.dialog_resources
		elif current_state == EPhaseState.CHOICE:
			return ALLIEES_CHOICE_DIALOGUES.dialog_resources
	elif current_phase == EnumCollection.EPhase.ARBRE:
		if current_state == EPhaseState.START:
			if KarmaManager.state == EnumCollection.EKarma.WISE:
				return ARBRE_START_DIALOGUES_SAGE.dialog_resources
			else:
				return ARBRE_START_DIALOGUES_CHAOS.dialog_resources
		elif current_state == EPhaseState.CHOICE:
			return ARBRE_CHOICE_DIALOGUES.dialog_resources
	elif current_phase == EnumCollection.EPhase.ANIMAL:
		if current_state == EPhaseState.START:
			if KarmaManager.state == EnumCollection.EKarma.WISE:
				return ANIMAL_START_DIALOGUES_SAGE.dialog_resources
			else:
				return ANIMAL_START_DIALOGUES_CHAOS.dialog_resources
		elif current_state == EPhaseState.CHOICE:
			return ANIMAL_CHOICE_DIALOGUES.dialog_resources
	elif current_phase == EnumCollection.EPhase.FRERES:
		if current_state == EPhaseState.START:
			if KarmaManager.state == EnumCollection.EKarma.WISE:
				return FRERES_START_DIALOGUES_SAGE.dialog_resources
			else:
				return FRERES_START_DIALOGUES_CHAOS.dialog_resources
		elif current_state == EPhaseState.CHOICE:
			return FRERES_CHOICE_DIALOGUES.dialog_resources
	return []
