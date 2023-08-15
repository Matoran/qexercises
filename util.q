.util.toString:{
    $[10=abs type x; x; string x]
    }

.util.toSym:{
    $[11=abs type x; x;`$.util.toString x]
    }

.util.protect:{
    $[-11=type x; @[get x;y;z]; @[x;y;z]]
    }