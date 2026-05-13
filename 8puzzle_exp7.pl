% Goal State
goal([1,2,3,4,5,6,7,8,0]).

% Move blank tile
move([0,B,C,D,E,F,G,H,I],[B,0,C,D,E,F,G,H,I]).
move([A,0,C,D,E,F,G,H,I],[0,A,C,D,E,F,G,H,I]).
move([A,B,C,0,E,F,G,H,I],[A,B,C,E,0,F,G,H,I]).
move([A,B,C,D,E,F,0,H,I],[A,B,C,D,E,F,H,0,I]).
move([A,B,C,D,E,F,G,0,I],[A,B,C,D,E,F,G,I,0]).
move([A,B,C,D,0,F,G,H,I],[A,B,C,0,D,F,G,H,I]).

% Heuristic: number of misplaced tiles
heuristic(State,H) :-
    goal(Goal),
    misplaced(State,Goal,H).

misplaced([],[],0).
misplaced([X|T1],[X|T2],H) :-
    misplaced(T1,T2,H).
misplaced([X|T1],[Y|T2],H) :-
    X \= Y,
    misplaced(T1,T2,H1),
    H is H1 + 1.

% Best First Search
best_first(Start,Goal,Path) :-
    bfs([[Start]],Goal,RevPath),
    reverse(RevPath,Path).

bfs([[Goal|Rest]|_],Goal,[Goal|Rest]).
bfs([Path|Paths],Goal,Solution) :-
    extend(Path,NewPaths),
    append(Paths,NewPaths,AllPaths),
    bfs(AllPaths,Goal,Solution).

extend([Node|Rest],NewPaths) :-
    findall([Next,Node|Rest],
            move(Node,Next),
            NewPaths).
