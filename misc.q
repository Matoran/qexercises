rcol:{[x;y;z]
    columns:select c from meta x;
    columns:update c:z from columns where c in y;
    columns:exec c from columns;
    columns xcol x
    }

myGroup:{
    unique:distinct x;
    result:{[values;current] where values=current}[x;] each unique;
    unique!result
    }