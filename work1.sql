.header on
select substr(date,1,4) as year,
       count(*) as n,
       sum(case when HOMERUNS=WINNER and HOMERUNS!='T' then 1 else 0 end) as HRW,
       sum(case when HOMERUNS!=WINNER and HOMERUNS != 'T' then 1 else 0 end) as HRL,
       abs(HomeHR-VisitorHR) as hr_diff
from home_runs
group by year,hr_diff
order by year,hr_diff
;
select substr(date,1,3) as decade,
       count(*) as n,
       sum(case when HOMERUNS=WINNER and HOMERUNS!='T' then 1 else 0 end) as HRW,
       sum(case when HOMERUNS!=WINNER and HOMERUNS != 'T' then 1 else 0 end) as HRL,
       abs(HomeHR-VisitorHR) as hr_diff
from home_runs 
group by decade,hr_diff
order by decade,hr_diff
;

select substr(date,1,2) as century,
       count(*) as n,
       sum(case when HOMERUNS=WINNER and HOMERUNS!='T' then 1 else 0 end) as HRW,
       sum(case when HOMERUNS!=WINNER and HOMERUNS != 'T' then 1 else 0 end) as HRL,
       abs(HomeHR-VisitorHR) as hr_diff
from home_runs
group by century,hr_diff
order by century,hr_diff
;
