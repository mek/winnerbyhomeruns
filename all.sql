.header on
select '0000' as type,
       count(*) as n,
       sum(case when HOMERUNS=WINNER  and HOMERUNS!='T' then 1 else 0 end) as HRW,
       sum(case when HOMERUNS!=WINNER and HOMERUNS!='T' then 1 else 0 end) as HRL
from home_runs
;
