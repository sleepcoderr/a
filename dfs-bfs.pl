% Graph edges
edge(a,b).
edge(a,c).
edge(b,d).
edge(b,e).
edge(c,f).
edge(e,g).

% Depth First Search
dfs(Start, Goal, Path) :-
    dfs_util(Start, Goal, [Start], Path).

dfs_util(Goal, Goal, Path, Path).
dfs_util(Current, Goal, Visited, Path) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    dfs_util(Next, Goal, [Next|Visited], Path).

% Breadth First Search dfs(a,g,path).
bfs(Start, Goal, Path) :-
    bfs_util([[Start]], Goal, Result),
    reverse(Result, Path).

bfs_util([[Goal|Rest]|_], Goal, [Goal|Rest]).
bfs_util([[Current|Rest]|Others], Goal, Path) :-
    findall([Next,Current|Rest],
           (edge(Current,Next), \+ member(Next,[Current|Rest])),
           NewPaths),
    append(Others, NewPaths, Queue),
    bfs_util(Queue, Goal, Path).
