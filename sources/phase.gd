@tool
class_name Phase
extends Resource

enum EStage {
    START,
    HILL,
    ALLIES,
    TREE,
    ANIMAL,
    BROTHERS,
    NONE
}

enum EState {
    START,
    CHOICE,
    END
}

@export var default_stage: EStage = EStage.START
@export var default_state: EState = EState.START

var _stage: EStage
var _state: EState

func default() -> Phase:
    _stage = default_stage
    _state = default_state

    return self


func next_state() -> Phase:
    match self._state:
        EState.START:
            self._state = EState.CHOICE
        EState.CHOICE:
            self._state = EState.END
        EState.END:
            self._state = EState.START
    
    return self

func next_stage() -> Phase:
    match self._stage:
        EStage.START:
            self._stage = EStage.HILL
        EStage.HILL:
            self._stage = EStage.ALLIES
        EStage.ALLIES:
            self._stage = EStage.TREE
        EStage.TREE:
            self._stage = EStage.ANIMAL
        EStage.ANIMAL:
            self._stage = EStage.BROTHERS

    return self
