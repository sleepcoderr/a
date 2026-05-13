% State representation: state(Jug1, Jug2)

% Initial state
initial(state(0,0)).

% Goal state (4L jug has 2 liters)
goal(state(4,_)).

% -------- Production Rules (Operations) --------

% Fill Jug1 completely (4L)
rule(state(_,Y), state(4,Y)).

% Fill Jug2 completely (3L)
rule(state(X,_), state(X,3)).

% Empty Jug1
rule(state(_,Y), state(0,Y)).

% Empty Jug2
rule(state(X,_), state(X,0)).

% Pour Jug1 -> Jug2
rule(state(X,Y), state(X1,Y1)) :-
    X > 0,
    Y < 3,
    Transfer is min(X, 3-Y),
    X1 is X - Transfer,
    Y1 is Y + Transfer.

% Pour Jug2 -> Jug1
rule(state(X,Y), state(X1,Y1)) :-
    Y > 0,
    X < 4,
    Transfer is min(Y, 4-X),
    X1 is X + Transfer,
    Y1 is Y - Transfer.

% -------- Search (DFS) --------

solve :-
    initial(State),
    dfs(State, [State]).

dfs(State, _) :-
    goal(State),
    write('Solution Found: '), write(State), nl.

dfs(State, Visited) :-
    rule(State, Next),
    \+ member(Next, Visited),
    dfs(Next, [Next|Visited]).
