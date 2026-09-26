extends Node

var current_phase: EnumCollection.EPhase = EnumCollection.EPhase.Location

func change_phase(phase: EnumCollection.EPhase):
    current_phase = phase
    SignalManager.OnNextPhase.emit(phase)