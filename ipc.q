/ Inter Process Communication
/ Simple utility for connecting to other q processes
/ .ipc.conns is a table of all processes and handles

\l log.q

.ipc.conns:([name:`proc1`proc2]port:5001 5002;handle:0Ni)

/ .ipc.conn should:
/ 		return an error if procName is not in .ipc.conns
/ 		if the handle is already open (not null handle), just return this handle
/ 		if the handle is not open (null handle), open one with hopen
/ 		use .log.info to print out a message saying connection opened to [procName]
/ 		put this handle into .ipc.conns so that it can be reused the next time
/ 		and return the newly created handle

.ipc.conn:{[procName]
    conn:.ipc.conns procName;
    if[null conn`port;'(string procName)," not found in .ipc.conns"];
    if[not null conn`handle;:conn`handle];
    h:hopen conn`port;
    .log.info "Connection opened to ",(string procName)," on handle ",string h;
    .ipc.conns[procName;`handle]:h;
    h
    }

/ .z.pc (port close) is the build in event handler that takes a single argument, which is the handle of the port that closed
/ if the argument is one of the handles in .ipc.conns, this function should update .ipc.conns to set the handle to null 
.z.pc:{
    matching:select from .ipc.conns where handle=x;
    matching:update handle:0Ni from matching;
    `.ipc.conns upsert matching;
    }

\

To test this, you should run two other processes on ports 5000 and 5001

If .ipc.conn`proc1 is called when the process is not up, it should return a null handle (0Ni)

If on the other hand the process is up, it should always return a valid handle, but the first time it is called it should also print out the message saying a handle was opened .e.g (using .log.info) 
“info 2023.03.24D16:13:56.446929975 Handle opened to proc1 on handle 4”

q).ipc.conn[`proc1]"\\p"
5001
q).ipc.conn[`proc2]”\\p”
5002

/ after you call .ipc.conn, you should check .ipc.conns to ensure a handle has been inserted
/ if you exit one of the other processes to which you’ve established a handle (by running \\ or exit 0), the handle should now be null in .ipc.conns
