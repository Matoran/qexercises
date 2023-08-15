n:10;eqBar:([]time:.z.p+til n;sym:n?`AA`BB;period:n?1 5 10h)
key`:.

save `eqBar
`:futBar set eqBar
`:cache/eqBar set eqBar
`:cache/futBar set eqBar
load `eqBar
load `futBar
.cache.eqBar:get `:cache/eqBar
.cache.futBar:get `:cache/futBar

n:1;new:([]time:.z.p+til n;sym:n?`AA`BB;period:n?1 5 10h)
`:eqBar upsert new
`:cache/eqBar upsert new

count eqBar:get `:eqBar
count .cache.eqBar:get `:cache/eqBar
