% Author        : Chenhan Ma
% ID            : 823289
% Email         : chenhanm@student.unimelb.edu.au
% COMP90048 Declarative Programming Project 2
% Slove Maths Puzzle(2*2, 3*3, 4*4) using Prolog

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%  Problem explanation  %%%%%%%%%%%%%

% Given heading of the row and column,
% 	and part of a puzzle, fill in the rest.
% The math puzzle has following rules:
% 	1. Each row and  column has no duplicates.
%	2. Numbers on the diagonal line are the same.
%	3. Heading of row and column equals to the sum
%		or the product of the numbers in that row 
%		or column.
%
% Example input:
% Puzzle=[[0,14,10,35],[14,_,_,_],[15,_,_,_],[28,_,1,_]],
% 	puzzle_solution(Puzzle).
%
% Sample puzzle:
%	 14 10 35
% 14  7  2  1
% 15  3  7  5
% 28  4  1  7

%%%%%%%%%%%%%%%  Document Purpose  %%%%%%%%%%%%%%%

% Simply validate the puzzle by project instruction:
% 1. Check the numbers on the diagonal line equals.
% 2. Check each row satisfies rules 1 and 3.
% 3. Tranpose the puzzle, turn column to row.
% 4. Check columns as the checking rows. (Same rules)
% 5. Try out values for every row, make digits ground.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%  Program  %%%%%%%%%%%%%%%%%%%%

% Load CLP(FD) library
:- ensure_loaded(library(clpfd)).

%%% puzzle_solution - Main predicate
% Input puzzle list of lists
% Success if result is ground and solve the puzzle.
% Predicate specification refers to Document Purpose.
% Predicate labeling/2 restrict domain of variable,
% 	and make sure all the digits are ground.

puzzle_solution([H|T]):-
	checkDiagonal(T, _, 1),
	checkAllRows(T),
	transpose([H|T], [_|TransposedT]),
	checkAllRows(TransposedT),
	maplist(labeling([]),[H|T]).

%%%%%%%%%%%%%%%%  Check Diagonal  %%%%%%%%%%%%%%%%%

%%% checkDiagonal
% Input: list of lists, tail of puzzle
% Make sure the number on the diagonal is equivalent
% Increment accumulator Index at each row
% Use nth0 predicate get the Nth element of a list
checkDiagonal([], _, _ ).
checkDiagonal([H|T], DiagonalValue, Index):-
	nth0(Index, H, DiagonalValue),
	Index1 #= Index+1,
	checkDiagonal(T, DiagonalValue, Index1).

%%%%%%%%%%%%  Check Rows And Columns  %%%%%%%%%%%%%

%%% checkAllRows
% Input: list of lists (Whole puzzle except first row)
% Recursively check each list as row is valid
% That each row satisfies rule 1, 3.
checkAllRows([]).
checkAllRows([H|T]):-
	checkRow(H),
	checkAllRows(T).

%%% checkRow
% Takes a row(list)
% Check the tail of the row has no duplication
% Check the head is the sum or the product of the tail.
checkRow([H|T]):-
	checkDuplicate([H|T]), 
	(sum(H, T); product(H, T)).

%%%%%%%%%%%%%%%% Other Predicates %%%%%%%%%%%%%%%%

%%% checkDuplicate
% Takes a List
% Check whether every element is different
checkDuplicate([]).
checkDuplicate([_|T]):-
	all_distinct(T).

%%% sum
% Calculate the sum of a list equals to a number
% Also each number of the list is between 1-9
sum(0, []).
sum(Sum, [H|T]):-
	sum(Sum1, T),
	checkNumber(H),
	Sum #= Sum1 + H.

%%% product
% The product of a list equals to the heading
% Each number of the list is between 1-9
product(1,[]).
product(Product, [H|T]):-
	product(Product1, T),
	checkNumber(H),
	Product #= Product1 * H.

%%% checkNumber
% Takes a number, make sure that it in between 1 and 9
checkNumber(Num):-
	Num #>= 1,
	Num #=< 9.
