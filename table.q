symMap:("PSS";enlist",")0:`:symMap.csv

getTicker:{[sym]
    symMapKey[sym;`ticker]
    }

upd:{[t;x]
    t upsert x
    }
upd[`symMap;(.z.p;`DEF;`$"DEF INDEX")]

symMapKey:select by sym from symMap
upd[`symMapKey;(`JKL;.z.p;`$"JKL INDEX")]
/ determine the different types x can be, the upd function should work regardless of type