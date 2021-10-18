#!/bin/sh
set -e

echo regular season
sqlite3 season_gamelogs.db < work1.sql

echo wild card
sqlite3 wc_playoffs_gamelogs.db < work1.sql

echo division series
sqlite3 dv_playoffs_gamelogs.db < work1.sql

echo league championship series
sqlite3 lc_playoffs_gamelogs.db < work1.sql

echo world series
sqlite3 ws_playoffs_gamelogs.db < work1.sql

echo all playoffs
sqlite3 all_playoffs_gamelogs.db < work1.sql
