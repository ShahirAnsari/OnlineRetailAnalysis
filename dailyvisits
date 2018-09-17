

raw = load 'retail.tsv';
retail = foreach raw generate (int) $0 as invno,(chararray) $1 as stcode,(int) $3 as qty,(chararray) $4 as date, (float) $5 as untprc,(chararray) $6 as custid,(chararray) $7 as country;
today = foreach retail generate invno,SUBSTRING(date,0,10) as days:chararray,qty*untprc as sale:double;
daygroup = group today by days;
invnos = DISTINCT(foreach byday generate group as day,today:invno as invno:int;
allinv = foreach daygroup generate group as day,today.invno as inv;

distinctinv = DISTINCT(foreach today generate days,invno);
groupinv = group distinctinv by days;
invnos = foreach groupinv generate group as day,COUNT(distinctinv.invno) as trans:int;


grouped = group today by days;
daynsale = foreach grouped generate group as day,SUM(today.sale) as sale:float;
daysaletrans = JOIN daynsale by day,invnos by day;
visitnsale = foreach daysaletrans generate daynsale::day as day,daynsale::sale as amount,invnos::trans as visits;
STORE visitnsale into 'dayamountvisits';
