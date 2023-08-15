h:hopen 5010
SYMS:`JPM`GE`IBM`AAPL
random.trade:{[n](n#.z.t;n?SYMS;10*1+n?10;price:n?10f)}
random.quote:{[n](n#.z.t;n?SYMS;n?10f;10*1+n?10;n?10f;10*1+n?10)}
.z.ts:{neg[h](`.u.upd;t;random[t:rand`trade`quote]1+rand 10)}
.z.pc:{if[h=x;-1"TP dropped";exit 0]}
\t 5000
