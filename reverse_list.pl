% Base case: empty list
reverse_list([], []).

% Recursive case
reverse_list([H|T], R) :-
    reverse_list(T, RT),
    append(RT, [H], R).
