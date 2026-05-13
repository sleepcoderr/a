% factorial.pl

% FACT
factorial(0, 1).

% RULE
factorial(N, F) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.

% ENTRY POINT
start :-
    write('Enter a number: '),
    read(N),
    factorial(N, F),
    write('Factorial is: '),
    write(F), nl.

