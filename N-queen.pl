% Main predicate
n_queens(N, Solution) :-
    length(Solution, N),
    queens(Solution, N).

% Place queens row by row
queens([], _).
queens([Q|Qs], N) :-
    queens(Qs, N),
    between(1, N, Q),
    safe(Q, Qs, 1).

% Check if queen placement is safe
safe(_, [], _).
safe(Q, [Q1|Qs], D) :-
    Q =\= Q1,
    abs(Q - Q1) =\= D,
    D1 is D + 1,
    safe(Q, Qs, D1).
