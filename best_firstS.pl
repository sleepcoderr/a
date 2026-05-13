% Graph edges (hardcoded)
edge(a,b).
edge(a,c).
edge(b,d).
edge(b,e).
edge(c,f).
edge(e,g).

% Heuristic values
h(a,6).
h(b,4).
h(c,5).
h(d,2).
h(e,1).
h(f,3).
h(g,0).

% Best First Search
best_first(Start, Goal, Path) :-
    bfs([[Start]], Goal, RevPath),
    reverse(RevPath, Path).

bfs([[Goal|Rest]|_], Goal, [Goal|Rest]).
bfs([Path|Paths], Goal, Solution) :-
    extend(Path, NewPaths),
    append(Paths, NewPaths, AllPaths),
    sort_paths(AllPaths, SortedPaths),
    bfs(SortedPaths, Goal, Solution).

extend([Node|Rest], NewPaths) :-
    findall([Next,Node|Rest],
           edge(Node,Next),
           NewPaths).

sort_paths(Paths, Sorted) :-
    map_list_to_pairs(path_heuristic, Paths, Pairs),
    keysort(Pairs, SortedPairs),
    pairs_values(SortedPairs, Sorted).

path_heuristic([Node|_], H) :-
    h(Node, H).
