\p 5010
\l schema.q

\d .u			/ move into .u namespace

/ Remember everything from here on down will be stored in .u until I move back to the root

T:tables`.		/ lists the tables in root and stores in t
w:T!()		/ Empty subscription dictionary

/ sub
/ takes t, which is a table name
/ Use .z.w to add the calling process’s handle to w (subscription dictionary)
/ if ` is passed in for t, add the handle to all entries in w
/ (.u.)sub takes table name and list of symbols
/ if ` is passed instead of list of symbols, it means the subscriber wants all symbols
sub:{[t;s]	
    $[t=`;sub[;s] each T;w[t],:enlist (.z.w;s)];
 }

/ upd
/ t(able name) and x(data)
/ x is a column dictionary (matrix of COLS x ROWS)
/ upd must convert this into a table
/ before publishing the updates to all handles subscribed to that table
/ the update to a process should be a 3 element e.g. for a trade update it should be (`upd;`trade;...), where `upd is a function name that never changes, and the 3rd element is the table data you’ve converted from the column dictionary
/ the publish should be asynchronous (not blocking)
/ The job of this function is to send the update to each subscriber as in tick1.q, but it has to filter the update according to the symbols that each subscriber wants
/ in order to keep upd clean, you might want to create one or more helper functions that upd calls, instead of doing it all in one function. Suggestions below
upd:{[t;x]
    subs:w[t];
    x:flip (cols t)!x;
    show subs;
    show x;
    ({[sub;symbols;t;x] neg[sub](`upd;t;sel[x;symbols])}[;;t;x] .) each subs;
 }

/ Suggestions for names of helper functions to be called

/ (.u.)sel, takes 2 arguments, don’t need to be declared
/ x -> table data
/ y -> symbol list (to filter table on) or ` (return all rows)
sel:{[x;y]
    $[y=`;x;select from x where sym in y]
 }


\d .		/ move back to root namespace

/ When a handle drops, if it’s the handle of a subscriber, remove it from .u.w
.z.pc:{[h]	
    {[x;h]
        r:{[x;h] $[x[0]=h;();x]}[;h] each .u.w[x];
        .u.w[x]: r where 0<count each r;
    }[;h] each .u.T;
    }
