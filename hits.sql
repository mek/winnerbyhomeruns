create table allhits as 
  select Date,
         VisitingTeam,
         HomeTeam,
         VisitorH,
         HomeH,
         case 
           when VisitorH>HomeH then 'V' 
           when VisitorH<HomeH then 'H' 
           else 'T'
         end as HITS,
         VisitorRunsScored,
         HomeRunsScore,
         case 
           when VisitorRunsScored>HomeRunsScore then 'V' 
           when VisitorRunsScored<HomeRunsScore then 'H' 
           else 'T' 
         end as WINNER
   from gamelogs;
