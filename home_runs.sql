create table home_runs as 
  select Date,
         VisitingTeam,
         HomeTeam,
         VisitorHR,
         HomeHR,
         case 
           when VisitorHR>HomeHR then 'V' 
           when VisitorHR<HomeHR then 'H' 
           else 'T'
         end as HOMERUNS,
         VisitorRunsScored,
         HomeRunsScore,
         case 
           when VisitorRunsScored>HomeRunsScore then 'V' 
           when VisitorRunsScored<HomeRunsScore then 'H' 
           else 'T' 
         end as WINNER,
   from gamelogs
