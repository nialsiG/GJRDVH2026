extends Node


enum EPhaseState {
	START,
	CHOICE,
}

const ON_START_DIALOGUE = preload("uid://f66fq3pqvoso")

const COLLINE_START_DIALOGUES = preload("uid://d3apeedp848o4")
const COLLINE_CHOICE_DIALOGUES = preload("uid://b8gmbkkxkshpx")
const COLLINE_BARK_DIALOGUES = preload("uid://15uo7ika8grd")

const ALLIEES_START_DIALOGUES_SAGE = preload("uid://yfpqyikr7sxy")
const ALLIEES_START_DIALOGUES_CHAOS = preload("uid://0uskebnyvsre")
const ALLIEES_CHOICE_DIALOGUES = preload("uid://yd345vtmbnmi")
const ALLIEES_BARK_DIALOGUES = preload("uid://21wk2mhwraxa")

const ARBRE_START_DIALOGUES_SAGE = preload("uid://bg3gsaev6rnoo")
const ARBRE_START_DIALOGUES_CHAOS = preload("uid://jgctj6nadeb6")
const ARBRE_CHOICE_DIALOGUES = preload("uid://dvin46hvbjtts")
const ARBRE_BARK_DIALOGUES = preload("uid://s882vnlfiki6")

const ANIMAL_START_DIALOGUES_SAGE = preload("uid://blhnn0v8ak5b5")
const ANIMAL_START_DIALOGUES_CHAOS = preload("uid://ffu6k5632fh")
const ANIMAL_CHOICE_DIALOGUES = preload("uid://be7idtjkjbtfu")
const ANIMAL_BARK_DIALOGUES = preload("uid://bt4qfvuvjtrxi")

const FRERES_START_DIALOGUES_SAGE = preload("uid://cgv63p7x8wae5")
const FRERES_START_DIALOGUES_CHAOS = preload("uid://b2o0ga517rvxv")
const FRERES_CHOICE_DIALOGUES = preload("uid://bud10cmwur2sx")
const FRERES_BARK_DIALOGUES = preload("uid://ck6sx4o4pg8lp")

var bark_timer_default: float = 20.0
var bark_timer: float = 0.0
var barked: bool = false
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

func _process(delta: float) -> void:
	if current_state == EPhaseState.CHOICE:
		if bark_timer > bark_timer_default && barked == false:
			barked = true
			SignalManager.NewDialogueArray.emit(_GetBarkDialogues())
		bark_timer += delta

func Reset():
	_ChangePhase(EnumCollection.EPhase.START)

func NextPhase():
	print("NextPhase")
	bark_timer = 0
	barked = false
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
	SignalManager.NextPhaseState.emit(current_phase, current_state)

func OnChoiceIsMade(_choice: EnumCollection.EChoice):
	print("end_phase = true")
	barked = true
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
	match current_phase:
		EnumCollection.EPhase.START:
			match current_state:
				EPhaseState.START:
					return ON_START_DIALOGUE.dialog_resources
		
		EnumCollection.EPhase.COLLINE:
			match current_state:
				EPhaseState.START:
					return COLLINE_START_DIALOGUES.dialog_resources
				EPhaseState.CHOICE:
					return COLLINE_CHOICE_DIALOGUES.dialog_resources

		EnumCollection.EPhase.ALLIES:
			match current_state:
				EPhaseState.START:
					match KarmaManager.state:
						EnumCollection.EKarma.WISE:
							return ALLIEES_START_DIALOGUES_SAGE.dialog_resources
						EnumCollection.EKarma.EVIL:
							return ALLIEES_START_DIALOGUES_CHAOS.dialog_resources
				EPhaseState.CHOICE:
					return ALLIEES_CHOICE_DIALOGUES.dialog_resources

		EnumCollection.EPhase.ARBRE:
			match current_state:
				EPhaseState.START:
					match KarmaManager.state:
						EnumCollection.EKarma.WISE:
							return ARBRE_START_DIALOGUES_SAGE.dialog_resources
						EnumCollection.EKarma.EVIL:
							return ARBRE_START_DIALOGUES_CHAOS.dialog_resources
				EPhaseState.CHOICE:
					return ARBRE_CHOICE_DIALOGUES.dialog_resources

		EnumCollection.EPhase.ANIMAL:
			match current_state:
				EPhaseState.START:
					match KarmaManager.state:
						EnumCollection.EKarma.WISE:
							return ANIMAL_START_DIALOGUES_SAGE.dialog_resources
						EnumCollection.EKarma.EVIL:
							return ANIMAL_START_DIALOGUES_CHAOS.dialog_resources
				EPhaseState.CHOICE:
					return ANIMAL_CHOICE_DIALOGUES.dialog_resources

		EnumCollection.EPhase.FRERES:
			match current_state:
				EPhaseState.START:
					match KarmaManager.state:
						EnumCollection.EKarma.WISE:
							return FRERES_START_DIALOGUES_SAGE.dialog_resources
						EnumCollection.EKarma.EVIL:
							return FRERES_START_DIALOGUES_CHAOS.dialog_resources
				EPhaseState.CHOICE:
					return FRERES_CHOICE_DIALOGUES.dialog_resources
	return []

func _GetBarkDialogues() -> Array[DialogueResource]:
	match current_phase:
		EnumCollection.EPhase.COLLINE:
			print("BARK ON COLINE")
			return COLLINE_BARK_DIALOGUES.dialog_resources
		EnumCollection.EPhase.ALLIES:
			print("BARK ON ALLIEES")
			return ALLIEES_BARK_DIALOGUES.dialog_resources
		EnumCollection.EPhase.ARBRE:
			print("BARK ON ARBRE")
			return ARBRE_BARK_DIALOGUES.dialog_resources
		EnumCollection.EPhase.ANIMAL:
			print("BARK ON ANIMAL")
			return ANIMAL_BARK_DIALOGUES.dialog_resources
		EnumCollection.EPhase.FRERES:
			print("BARK ON FRERES")
			return FRERES_BARK_DIALOGUES.dialog_resources
	return []
