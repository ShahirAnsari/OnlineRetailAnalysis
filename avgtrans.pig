seg = foreach segregate generate (chararray) $0 as country,(int) $1 as invno,(chararray) $2 as stcode;
  groupbyinv = GROUP seg by invno;
  itemsperinv = foreach groupbyinv generate group as invno,COUNT(seg.stcode) as noftiems:int;
  addcountry = JOIN itemsperinv by invno,seg by invno;
  countryseg = foreach addcountry generate addcountry::itemsperinv:invno as invno;
  addcountry = JOIN itemsperinv by invno,seg by invno;
  segcountry = foreach addcountry generate itemsperinv::invno as invno,itemsperinv::noftiems as nofitems,seg::country as country;
  distincts = DISTINCT(foreach segcountry generate country,invno,nofitems);
  ctrgroup = GROUP distincts by country;
  values = foreach ctrgroup generate group as country,COUNT(distincts.invno) as notrans:int,SUM(distincts.nofitems) as nofitems:int;
  avgitems = foreach values generate country,nofitems/noftrans as avgitems:float;
.
