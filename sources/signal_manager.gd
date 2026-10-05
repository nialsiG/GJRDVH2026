extends Node

@warning_ignore("unused_signal") signal NewGame
@warning_ignore("unused_signal") signal StopGame
@warning_ignore("unused_signal") signal ChoiceIsMade(choice: EnumCollection.EChoice)
@warning_ignore("unused_signal") signal GameOver
@warning_ignore("unused_signal") signal PhaseNewDialogue(dialogue: Dialogue)
@warning_ignore("unused_signal") signal PhaseEndChoiceDialogue(phase: Phase)
@warning_ignore("unused_signal") signal PhaseEnd
@warning_ignore("unused_signal") signal DialogueUIClickedOnDialogue
