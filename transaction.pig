

top = JOIN retail by country LEFTOUTER,highesty country;
  joinretailrevenue = JOIN retail by country LEFT OUTER,highest by country;
  filtered = FILTER joinretailrevenue by revenue::country is not null;
  segregate = foreach filtered generate revenue::country as country,inv,stcode,descp,qty,date,untpr,custid,totrev;

  custids = DISTINCT(foreach segregate generate country,custid);
  idgroup = GROUP custids by country;
  numcust = foreach idgroup generate group as country,COUNT(custids.custid) as numofcust:int;

  invoices = foreach segregate generate (chararray) $0 as country,(int)$1 as inv;
  distinctinvs = DISTINCT(foreach segregate generate country,inv);
  invgroup = GROUP distinctinvs by country;
  transactions = foreach invgroup generate group as country,COUNT(distinctinvs.inv) as numtrancs:int;
