% Base case
list_length([], 0).

% Recursive case
list_length([_|T], N) :-
    list_length(T, N1),
    N is N1 + 1.
