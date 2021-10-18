#!/bin/sh
set -e

mkdir -p downloads
cd downloads
test -f gl1871_2020.zip || ( wget https://www.retrosheet.org/gamelogs/gl1871_2020.zip && unzip gl1871_2020.zip)
test -f glwc.zip || (wget https://www.retrosheet.org/gamelogs/glwc.zip &&  unzip glwc.zip)
test -f gldv.zip || (wget https://www.retrosheet.org/gamelogs/gldv.zip && unzip gldv.zip) 
test -f gllc.zip || ( wget https://www.retrosheet.org/gamelogs/gllc.zip && unzip gllc.zip) 
test -f glws.zip || (wget https://www.retrosheet.org/gamelogs/glws.zip && unzip glws.zip)

echo regular season
rm -rf ../season_gamelogs.db 
sqlite3 ../season_gamelogs.db < ../gamelog.sql
for a in `ls GL[0-9]*.TXT`
do 
  echo .import --csv $a gamelogs | sqlite3 ../season_gamelogs.db
done
sqlite3 ../season_gamelogs.db < ../home_runs.sql
sqlite3 ../season_gamelogs.db < ../work.sql

echo wild card
rm -f ../wc_playoffs_gamelogs.db
sqlite3 ../wc_playoffs_gamelogs.db < ../gamelog.sql
echo '.import --csv GLWC.TXT gamelogs' | sqlite3 ../wc_playoffs_gamelogs.db
sqlite3 ../wc_playoffs_gamelogs.db < ../home_runs.sql
sqlite3 ../wc_playoffs_gamelogs.db < ../work.sql

echo division series
rm -f ../dv_playoffs_gamelogs.db
sqlite3 ../dv_playoffs_gamelogs.db < ../gamelog.sql
echo '.import --csv GLDV.TXT gamelogs' | sqlite3 ../dv_playoffs_gamelogs.db
sqlite3 ../dv_playoffs_gamelogs.db < ../home_runs.sql
sqlite3 ../dv_playoffs_gamelogs.db < ../work.sql

echo league championship series
rm -f ../lc_playoffs_gamelogs.db
sqlite3 ../lc_playoffs_gamelogs.db < ../gamelog.sql
echo '.import --csv GLLC.TXT gamelogs' | sqlite3 ../lc_playoffs_gamelogs.db
sqlite3 ../lc_playoffs_gamelogs.db < ../home_runs.sql
sqlite3 ../lc_playoffs_gamelogs.db < ../work.sql

echo world series
rm -f ../ws_playoffs_gamelogs.db
sqlite3 ../ws_playoffs_gamelogs.db < ../gamelog.sql
echo '.import --csv GLWS.TXT gamelogs' | sqlite3 ../ws_playoffs_gamelogs.db
sqlite3 ../ws_playoffs_gamelogs.db < ../home_runs.sql
sqlite3 ../ws_playoffs_gamelogs.db < ../work.sql

echo all playoffs
rm -f ../all_playoffs_gamelogs.db
sqlite3 ../all_playoffs_gamelogs.db < ../gamelog.sql
echo '.import --csv GLWC.TXT gamelogs' | sqlite3 ../all_playoffs_gamelogs.db
echo '.import --csv GLDV.TXT gamelogs' | sqlite3 ../all_playoffs_gamelogs.db
echo '.import --csv GLLC.TXT gamelogs' | sqlite3 ../all_playoffs_gamelogs.db
echo '.import --csv GLWS.TXT gamelogs' | sqlite3 ../all_playoffs_gamelogs.db
sqlite3 ../all_playoffs_gamelogs.db < ../home_runs.sql
sqlite3 ../all_playoffs_gamelogs.db < ../work.sql

cd ..
