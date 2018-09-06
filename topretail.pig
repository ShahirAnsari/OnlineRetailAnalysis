data = load 'retail.tsv';
retail = foreach data generate (int) $0 as invoice,(chararray) $1 as stkcode,(chararray) $2 as descp,(int) $3 as qty,
	(chararray) $4 as invdate,(double) $5 as untprice,(chararray) $6 as custid,(chararray) $7 as country;
revenue =  foreach retail generate descp,qty,untprice,qty*untprice as total:double;
revenue2  =  foreach revenue generate qty..country;

revenue3 = foreach revenue generate total:float,country;
grouped = GROUP revenue3 by country;
withrevenue = foreach grouped generate group as countryy,SUM(revenue3.total) as totalrev:float;
descg = ORDER withrevenue by revenue desc;
highest = LIMIT descg 5;
STORE highest into 'toprev';
