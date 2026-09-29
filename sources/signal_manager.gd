extends Node

@warning_ignore("unused_signal") signal NewGame
@warning_ignore("unused_signal") signal StopGame
@warning_ignore("unused_signal") signal PlayerClickedOnMe(object: Node)
@warning_ignore("unused_signal") signal OnNextPhase(phase: EnumCollection.EPhase)
@warning_ignore("unused_signal") signal PlayerIsNotIdle
@warning_ignore("unused_signal") signal PlayerIsIdle
@warning_ignore("unused_signal") signal PlayerClickedOnDialogue
@warning_ignore("unused_signal") signal DialogueStarted
@warning_ignore("unused_signal") signal DialogueEnded
@warning_ignore("unused_signal") signal NextDialogue
@warning_ignore("unused_signal") signal NewDialogueArray(array: Array[Dialogue])
@warning_ignore("unused_signal") signal ChoiceIsMade(choice: EnumCollection.EChoice)
@warning_ignore("unused_signal") signal StartPhase(dialogues: MultilineDialogResource)
@warning_ignore("unused_signal") signal GameOver()
@warning_ignore("unused_signal") signal NextPhaseState(phase: EnumCollection.EPhase, state: PhaseManager.EPhaseState)
