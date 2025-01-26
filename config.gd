extends Node


enum DIFICULTY {EASY,MEDIUM,HARD}

var dificulty : DIFICULTY = DIFICULTY.EASY

func get_modifier() -> float:
	match dificulty:
		DIFICULTY.EASY:
			return 0.5
		DIFICULTY.MEDIUM:
			return 0.33
		DIFICULTY.HARD:
			return 0.25
	return 0.25
	
func get_samples() -> int:
	match dificulty:
		DIFICULTY.EASY:
			return 2
		DIFICULTY.MEDIUM:
			return 3
		DIFICULTY.HARD:
			return 4
	return 4
