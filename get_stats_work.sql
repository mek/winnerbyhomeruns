.header on
select substr(date,1,4) as year,
       count(*) as n,
       sum(case when KS=WINNER  and KS!='T' then 1 else 0 end) as HRW,
       sum(case when KS!=WINNER and KS!='T' then 1 else 0 end) as HRL
from stats
group by year
;

select substr(date,1,3) as decade,
       count(*) as n,
       sum(case when KS=WINNER  and KS!='T' then 1 else 0 end) as HRW,
       sum(case when KS!=WINNER and KS!='T' then 1 else 0 end) as HRL
from stats 
group by decade
;

select substr(date,1,2) as century,
       count(*) as n,
       sum(case when KS=WINNER  and KS!='T' then 1 else 0 end) as HRW,
       sum(case when KS!=WINNER and KS!='T' then 1 else 0 end) as HRL
from stats
group by century
;
