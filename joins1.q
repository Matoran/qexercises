trade:([]sym:20?`JPM`BP`MS`AAPL`UBS;size:20?100;price:20?10f)

reference:([sym:`JPM`BP`MS`UBS]hq:`US`UK`US`CH;name:`$("JP Morgan Chase";"British Petroleum";"Morgan Stanley";"Union Bank of Switzerland"))

regionMap:`US`UK`CH!`NA`EMEA`EMEA


getAllTrades:{
    trade
    }

getValidTrades:{
    trade ij reference
    }

getCountryTrades:{
    select from trade ij reference where hq=x
    }

getRegionTrades:{[reg]
    select from trade ij reference where hq in where regionMap=reg
    }

getMatchingTrades:{[str]
    select from trade ij reference where name like str
    }