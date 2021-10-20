drop table if exists stats
;
create table stats as 
  select Date,
         VisitingTeam,
         HomeTeam,
         VisitorHR,
         HomeHR,
         VisitorH,
         HomeH,
         VisitorK,
         HomeK,
         case 
           when VisitorHR>HomeHR then 'V' 
           when VisitorHR<HomeHR then 'H' 
           else 'T'
         end as HOMERUNS,
         case 
           when VisitorH>HomeH then 'V' 
           when VisitorH<HomeH then 'H' 
           else 'T'
         end as HITS,
         case 
           when VisitorK>HomeK then 'V' 
           when VisitorK<HomeK then 'H' 
           else 'T'
         end as KS,
         VisitorRunsScored,
         HomeRunsScore,
         case 
           when VisitorRunsScored>HomeRunsScore then 'V' 
           when VisitorRunsScored<HomeRunsScore then 'H' 
           else 'T' 
         end as WINNER
   from gamelogs
;
