correspond(E1,[E1|_],E2,[E2|_]).
correspond(E1, [_|T1], E2, [_|T2]) :-
	correspond(E1,T1,E2,T2).

interleave([[]],[]).
interleave([[],[]],[]).
interleave([[],[],[]],[]).

interleave([[X|Xs]],[X|T2]) :-
	interleave([Xs],T2).
interleave([[X|Xs],[Y|Ys]],[X,Y|T2]):-
	interleave([Xs,Ys],T2).
interleave([[X|Xs],[Y|Ys],[Z|Zs]],[X,Y,Z|T2]):-
	interleave([Xs,Ys,Zs],T2).

replace(Var, Var, Val, Val).    
replace(Expr0, Var, Val, Expr) :-
	dif(Expr0, Var),
    Expr0 =.. [H|T1],
    maplist(support(Var, Val), T1, T2),
    Expr =.. [H|T2].

support(Var, Val, Expr0, Expr) :- replace(Expr0, Var, Val, Expr).

partial_eval(Expr0, Var, Val, Expr):- 
	replace(Expr0, Var, Val, NewExpr),
	Expr is NewExpr. 