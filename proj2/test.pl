:- ensure_loaded(library(clpfd)).

checkColumn(Puzzle):-
	transpose(Puzzle, T),
	length(T, 4).
