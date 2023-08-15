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
sub:{[t]	
    $[t=`;sub each T;w[t],:.z.w];
    }

/ upd
/ t(able name) and x(data)
/ x is a column dictionary (matrix of COLS x ROWS)
/ upd must convert this into a table
/ before publishing the updates to all handles subscribed to that table
/ the update to a process should be a 3 element e.g. for a trade update it should be (`upd;`trade;...), where `upd is a function name that never changes, and the 3rd element is the table data you’ve converted from the column dictionary
/ the publish should be asynchronous (not blocking)
upd:{[t;x]
    subs:w[t];
    x:flip x;
    if[0=count subs;:()];
    {[sub;t;x] neg[sub](`upd;t;x)}[;t;x] each subs;
    }

\d .		/ move back to root namespace

/ When a handle drops, if it’s the handle of a subscriber, remove it from .u.w
.z.pc:{[h]	
    {[x;h].u.w[x]: .u.w[x] except h}[;h] each .u.T;
    }
